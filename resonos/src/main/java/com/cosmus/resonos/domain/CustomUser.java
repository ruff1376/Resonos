package com.cosmus.resonos.domain;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.oidc.OidcIdToken;
import org.springframework.security.oauth2.core.oidc.OidcUserInfo;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.security.oauth2.core.user.OAuth2User;

import com.cosmus.resonos.domain.user.UserAuth;
import com.cosmus.resonos.domain.user.Users;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Getter
public class CustomUser implements UserDetails, OAuth2User, OidcUser  {
    private final Users user;
    private final List<UserAuth> authList;

    private Map<String, Object> attributes;
    public CustomUser(Users user) {
        this.user = user;
        this.authList = user.getAuthList();
    }

    // 소셜 로그인용
    public CustomUser(Users user, Map<String, Object> attributes) {
        this.user = user;
        this.authList = user.getAuthList();
        this.attributes = attributes;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authList.stream()
                .map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
                .collect(Collectors.toList());
    }
    public Long getId() { return user.getId(); }
    @Override public String getPassword() { return user.getPassword(); }
    @Override public String getUsername() { return user.getUsername(); }
    @Override public boolean isAccountNonExpired() { return true; }
    @Override public boolean isAccountNonLocked() { return true; }
    @Override public boolean isCredentialsNonExpired() { return true; }
    @Override public boolean isEnabled() { log.info("isEnabled() : {}", user.isEnabled()); return user.isEnabled();}
    // ADMIN 권한 여부 확인 메서드 추가
    public boolean isAdmin() {
        return authList.stream()
                .anyMatch(auth -> "ROLE_ADMIN".equals(auth.getAuth()));
    }

    // 소셜 로그인 회원
    @Override
    public Map<String, Object> getAttributes() {
        return attributes;
    }

    @Override
    public String getName() {
        return String.valueOf(user.getUsername());
    }

    @Override
    public Map<String, Object> getClaims() {
        throw new UnsupportedOperationException("Unimplemented method 'getClaims'");
    }

    @Override
    public OidcUserInfo getUserInfo() {
        throw new UnsupportedOperationException("Unimplemented method 'getUserInfo'");
    }

    @Override
    public OidcIdToken getIdToken() {
        throw new UnsupportedOperationException("Unimplemented method 'getIdToken'");
    }
}
