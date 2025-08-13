package com.cosmus.resonos.service.user;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.admin.UserActivityLog;
import com.cosmus.resonos.domain.admin.UserSanction;
import com.cosmus.resonos.domain.admin.UsersTotalLikes;
import com.cosmus.resonos.domain.user.GenreCount;
import com.cosmus.resonos.domain.user.PublicUserDto;
import com.cosmus.resonos.domain.user.UserAuth;
import com.cosmus.resonos.domain.user.UserNoti;
import com.cosmus.resonos.domain.user.Users;
import com.cosmus.resonos.mapper.admin.UserRoleMapper;
import com.cosmus.resonos.mapper.user.UserMapper;
import com.cosmus.resonos.service.admin.UserActivityLogService;
import com.cosmus.resonos.service.admin.UserSanctionService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service("UserService")
public class UserServiceImpl implements UserService {

    @Autowired UserMapper userMapper;

    @Autowired UserRoleMapper userRoleMapper;

    @Autowired PasswordEncoder passwordEncoder;

    @Lazy @Autowired AuthenticationManager authenticationManager;

    @Autowired UserActivityLogService userActivityLogService;

    /**
     * 회원가입
     * 1. 비밀번호를 암호화
     * 2. 회원 등록
     * 3. 기본 권한을 등록
     */
    @Override
    @Transactional          // 트랜잭션 처리를 설정 (회원정보, 회원권한)
    public boolean join(Users user) throws Exception {
        String encodedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encodedPassword);
        user.setEnabled(true);
        boolean result = userMapper.join(user) > 0 ? true : false;
        if (result) {
            UserAuth userAuth = new UserAuth();
            userAuth.setUsername(user.getUsername());
            userAuth.setAuth("ROLE_USER"); // 2L = ROLE_USER, 1L = ROLE_ADMIN 등
            int authResult = userMapper.insertAuth(userAuth);

            // 알림 기본 세팅
            if(authResult > 0) {
                Long id = userMapper.select(user.getUsername()).getId();
                if(id != null)
                    userMapper.basicNotiSetting(id);
            }
        }
        return result;
    }

    @Override
    public int insertAuth(UserAuth userAuth) throws Exception {
        int result = userMapper.insertAuth(userAuth);
        return result;
    }

    @Override
    public boolean login(Users user, HttpServletRequest request) {
        // 💍 토큰 생성
        String username = user.getUsername();
        String password = user.getPassword();
        UsernamePasswordAuthenticationToken token
            = new UsernamePasswordAuthenticationToken(username, password);

        // 토큰을 이용하여 인증
        Authentication authentication = authenticationManager.authenticate(token);

        // 인증 여부 확인
        boolean result = authentication.isAuthenticated();

        // 인증에 성공하면 SecurityContext 에 설정
        if( result ) {
            SecurityContext securityContext = SecurityContextHolder.getContext();
            securityContext.setAuthentication(authentication);

            // 세션 인증 정보 설정 (세션이 없으면 새로 생성)
            HttpSession session = request.getSession(true); // 세션이 없으면 생성
            session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);

            // 활동 로그 기록
            UserActivityLog log = new UserActivityLog();
            log.setUserId(user.getId());
            log.setAction("로그인");
            log.setDetail("성공");
            log.setIpAddress(request.getRemoteAddr());
            log.setUserAgent(request.getHeader("User-Agent"));
            log.setCreatedAt(new Date());
            try {
                userActivityLogService.logActivity(log);
            } catch (Exception e) {
                // 예외를 로깅하거나 무시할 수 있습니다. 여기서는 무시합니다.
            }
        }
        return result;
    }

    @Override
    public Users select(String username) throws Exception {
        Users user = userMapper.select(username);
        return user;
    }

    @Override
    public boolean isAdmin() throws Exception {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if(auth == null || !auth.isAuthenticated()) return false;

        return auth.getAuthorities().stream()
                                    .map(GrantedAuthority::getAuthority)
                                    .anyMatch(role -> role.equals("ROLE_ADMIN"));
    }

    /* 회원 정보 수정 - 기존 */
    // @Override
    // public boolean update(Users user) throws Exception {
    //     // 비밀번호 입력값이 있을 때만 변경
    //     if (user.getPassword() != null && !user.getPassword().isEmpty()) {
    //         String encodedPassword = passwordEncoder.encode(user.getPassword());
    //         user.setPassword(encodedPassword);
    //     } else {
    //         // 기존 비밀번호 유지: DB에서 조회해서 set
    //         String currentPassword = userMapper.selectPasswordById(user.getId());
    //         user.setPassword(currentPassword);
    //     }
    //     return userMapper.update(user) > 0;
    // }


    // react에서 회원 정보 수정을 위해서 새롭게 작성 됨 
    @Transactional
    @Override
    public boolean update(Users user) throws Exception {
        // 기존 회원 정보 조회
        Users existingUser = userMapper.selectById(user.getId());

    // 비밀번호 처리
    if (user.getPassword() != null && !user.getPassword().isEmpty()) {
        String encodedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encodedPassword);
    } else {
        String currentPassword = userMapper.selectPasswordById(user.getId());
        user.setPassword(currentPassword);
    }

    // username 변경 체크
    if (!existingUser.getUsername().equals(user.getUsername())) {
        // 1. 기존 권한 삭제 (user_auth에서 기존 username 참조 row 삭제)
        userMapper.deleteAuthByUsername(existingUser.getUsername());

        // 2. 회원 업데이트 (user 테이블의 username 변경)
        userMapper.update(user);

        // 3. 새로운 username으로 권한 재등록
        if(user.getAuthList() != null) {
            for(UserAuth auth : user.getAuthList()) {
                auth.setUsername(user.getUsername());
                userMapper.insertAuth(auth);
            }
        }
        return true;
    } else {
        // 변경 없으면 권한 수정 처리 등 필요 시 여기서
        if(user.getAuthList() != null) {
            for(UserAuth auth : user.getAuthList()) {
                userMapper.updateAuth(auth);
            }
        }
        // 회원 업데이트
        return userMapper.update(user) > 0;
    }
    }




    @Autowired
    private UserSanctionService userSanctionService;
    // react - 어드민 - 유저 삭제시 USER 테이블 외래키 오류로 인해서 수정함
    @Override
    @Transactional
    public boolean delete(Long id) throws Exception {
        Users user = userMapper.selectById(id);
        if (user != null) {
            // 1. 권한 정보 먼저 삭제
            userMapper.deleteAuthByUsername(user.getUsername());
            // 2. 제재 기록 삭제
            List<UserSanction> sanctions = userSanctionService.getSanctionsByUserId(id);
            if (sanctions != null) {
                for (UserSanction sanction : sanctions) {
                    userSanctionService.delete(sanction.getId());
                }
            }
            // 3. user 삭제
            return userMapper.delete(id) > 0;
        }
        return false;
    }

    @Override
    public List<Users> list() throws Exception {
        return userMapper.list();
    }

    @Override
    public List<UserAuth> listAuth() throws Exception {
        return userMapper.listAuth();
    }

    @Override
    public int countAll() throws Exception {
        return userMapper.countAll();
    }

    @Override
    public boolean findByUsername(String username) throws Exception {
        return userMapper.findByUsername(username) != null ? true : false;
    }

    @Override
    public boolean findByNickname(String nickname) throws Exception {
        return userMapper.findByNickname(nickname) != null ? true : false;
    }


    // 아래 코드는 컨트롤러에서 사용해야 하므로 주석 처리
    /*
    // 예시: UserRoleController의 일부
    @PostMapping("/grant-admin/{userId}")
    public String grantAdmin(@PathVariable Long userId) throws Exception {
        userRoleService.grantRole(userId, "ROLE_ADMIN");
        return "redirect:/user-roles";
    }

    @PostMapping("/revoke-admin/{userId}")
    public String revokeAdmin(@PathVariable Long userId) throws Exception {
        userRoleService.revokeRole(userId, "ROLE_ADMIN");
        return "redirect:/user-roles";
    }

    // 관리자만 접근 가능한 컨트롤러
    // @PreAuthorize("hasRole('ADMIN')")
    // @GetMapping("/admin/only")
    // public String adminOnlyPage() {
    //     return "admin/only";
    // }
    */


    @Override
    public List<UserAuth> selectAuthByUsername(String username) throws Exception {
        return userMapper.selectAuthByUsername(username);
    }

    @Override
    public int updateAuth(UserAuth userAuth) throws Exception {
        return userMapper.updateAuth(userAuth);
    }

    @Override
    public int deleteAuthByUsername(String username) throws Exception {
        return userMapper.deleteAuthByUsername(username);
    }

    @Override
    public List<Users> searchByKeyword(String keyword) throws Exception {
        return userMapper.searchByKeyword(keyword);
    }

    @Override
    public boolean enableUser(Long id, boolean enabled) throws Exception {
        return userMapper.updateEnabled(id, enabled) > 0;
    }

    @Override
    public boolean banUser(Long id, boolean ban) throws Exception {
        return userMapper.updateBan(id, ban) > 0;
    }

    @Override
    public void deleteSpecificAuth(String username, String auth) throws Exception {
        userMapper.deleteSpecificAuth(username, auth);
    }
    @Override
    public boolean hasAuth(String username, String auth) throws Exception {
        return userMapper.hasAuth(username, auth) > 0;
    }

    /**
     * 아이디 찾기
     */
    @Override
    public String findId(String email) throws Exception {
        return userMapper.findId(email);
    }
    /**
     * 비밀번호 초기화
     */
    @Override
    public boolean updatePassword(Long id, String password) throws Exception {
        String encodedPassword = passwordEncoder.encode(password);
        return userMapper.updatePassword(id, encodedPassword) > 0;
    }
    @Override
    public Users selectById(Long id) throws Exception {
        return userMapper.selectById(id);
    }

    /**
     * 회원이 수정
     */
    @Override
    public boolean updateFromUser(Users user) throws Exception {
        return userMapper.updateFromUser(user) > 0 ? true : false;
    }

    @Override
    public PublicUserDto publicSelectById(Long id) throws Exception {
        return userMapper.publicSelectById(id);
    }

    @Override
    public List<Users> searchList(String keyword) throws Exception {
        return userMapper.searchList(keyword);
    }

    @Override
    public List<Users> allSearchList(Map<String, Object> paramMap) throws Exception {
        String keyword = (String) paramMap.get("keyword");
        Pagination pagination = (Pagination) paramMap.get("pagination");
        long total = userMapper.searchCount(keyword);
        if (pagination != null) {
            pagination.setTotal(total);
        }
        Map<String, Object> queryMap = new HashMap<>();
        queryMap.put("keyword", keyword);
        queryMap.put("index", pagination.getIndex());
        queryMap.put("size", pagination.getSize());
        return userMapper.allSearchList(queryMap);
    }

    @Override
    public long searchCount(String keyword) throws Exception {
        return userMapper.searchCount(keyword);
    }

    @Override
    public String selectPasswordById(Long id) throws Exception {
        return userMapper.selectPasswordById(id);
    }

    @Override
    public boolean comparePassword(String pw, String dbPw) throws Exception {
        return passwordEncoder.matches(pw, dbPw);
    }

    @Override
    public boolean changePassword(String newPassword, Long loginUserId) throws Exception {
        return userMapper.changePassword(passwordEncoder.encode(newPassword), loginUserId) > 0;
    }

    @Override
    public Users findByProviderAndProviderId(String provider, String providerId) throws Exception {
        return userMapper.findByProviderAndProviderId(provider, providerId);
    }

    @Override
    public boolean insertSnsUser(Users user) throws Exception {
        return userMapper.insertSnsUser(user) > 0;
    }

    @Override
        public long countByKeyword(String keyword) throws Exception {
            return userMapper.countByKeyword(keyword);
        }

        @Override
        public List<Users> searchByKeywordPaging(String keyword, int index, int size) throws Exception {
            return userMapper.searchByKeywordPaging(keyword, index, size);
        }

        @Override
        public List<Users> listPaging(int index, int size) throws Exception {
            return userMapper.listPaging(index, size);
        }

        @Override
        public List<GenreCount> likedGenreData(Long userId) throws Exception {
            return userMapper.likedGenreData(userId);
        }

        @Override
        public UsersTotalLikes usersTotalLikes(Long userId) throws Exception {
            return userMapper.usersTotalLikes(userId);
        }

        @Override
        public boolean banUser(Long id, boolean ban, String reason) throws Exception {
            return userMapper.banUser(id, ban, reason) > 0;
        }

        @Override
        public boolean basicNotiSetting(Long userId) throws Exception {
            return userMapper.basicNotiSetting(userId) > 0;
        }

        @Override
        public boolean changeNoti(UserNoti userNoti) throws Exception {
            return userMapper.changeNoti(userNoti) > 0;
        }

        @Override
        public List<UserNoti> getNotiStatus(Long userId) throws Exception {
            return userMapper.getNotiStatus(userId);
        }

        @Override
        public long countAllUsers() throws Exception {
            return userMapper.countAllUsers();
        }

        @Override
        public List<Users> listPagingA(long index, long size) throws Exception {
            return userMapper.listPagingA(index, size);
        }
}
