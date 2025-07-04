package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cosmus.resonos.domain.UserAuth;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.mapper.UserMapper;
import com.cosmus.resonos.mapper.UserRoleMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service("UserService")
public class UserServiceImpl implements UserService {

    @Autowired UserMapper userMapper;

    @Autowired UserRoleMapper userRoleMapper;

    @Autowired PasswordEncoder passwordEncoder;

    @Autowired AuthenticationManager authenticationManager;

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
        boolean result = userMapper.join(user) > 0 ? true : false;
        if (result) {
            UserAuth userAuth = new UserAuth();
            userAuth.setUsername(user.getUsername());
            userAuth.setAuth("ROLE_USER"); // 2L = ROLE_USER, 1L = ROLE_ADMIN 등
            userMapper.insertAuth(userAuth);
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

    @Override
    public boolean update(Users user) throws Exception {
        return userMapper.update(user) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return userMapper.delete(id) > 0;
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
}
