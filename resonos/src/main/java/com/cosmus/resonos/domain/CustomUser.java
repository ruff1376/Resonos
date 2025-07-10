package com.cosmus.resonos.domain;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Getter;

@Getter
public class CustomUser implements UserDetails {
    private final Users user;
    private final List<UserAuth> authList;

    public CustomUser(Users user) {
        this.user = user;
        this.authList = user.getAuthList();
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
    @Override public boolean isEnabled() { return user.isEnabled(); }
    // ADMIN 권한 여부 확인 메서드 추가
    public boolean isAdmin() {
        return authList.stream()
                .anyMatch(auth -> "ROLE_ADMIN".equals(auth.getAuth()));
    }
}
