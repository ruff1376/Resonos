package com.cosmus.resonos.service;

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

import com.cosmus.resonos.domain.User;
import com.cosmus.resonos.domain.UserAuth;
import com.cosmus.resonos.domain.UserRole;
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
    public int join(User user) throws Exception {
        String encodedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encodedPassword);
        int result = userMapper.join(user);
        if (result > 0) {
            UserRole userRole = new UserRole();
            userRole.setUserId(user.getNo());
            userRole.setRoleId(2L); // 2L = ROLE_USER, 1L = ROLE_ADMIN 등
            userRoleMapper.insert(userRole);
        }
        return result;
    }

    @Override
    public int insertAuth(UserAuth userAuth) throws Exception {
        int result = userMapper.insertAuth(userAuth);
        return result;
    }

    @Override
    public boolean login(User user, HttpServletRequest request) {
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
    public User select(String username) throws Exception {
        User user = userMapper.select(username);
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
    public boolean update(User user) throws Exception {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'update'");
    }

    @Override
    public boolean delete(Long id) throws Exception {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'delete'");
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
}
