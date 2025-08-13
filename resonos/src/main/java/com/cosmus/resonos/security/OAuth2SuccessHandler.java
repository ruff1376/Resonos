package com.cosmus.resonos.security;

import java.io.IOException;
import java.time.Duration;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.stereotype.Component;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.user.Users;
import com.cosmus.resonos.security.provider.JwtProvider;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class OAuth2SuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler  {

  private PersistentTokenBasedRememberMeServices rememberMeServices;

  @Autowired
  private JwtProvider jwtProvider;

  // 생성자 주입
  public OAuth2SuccessHandler(PersistentTokenBasedRememberMeServices rememberMeServices) {
      this.rememberMeServices = rememberMeServices;
  }

  @Override
  public void onAuthenticationSuccess(HttpServletRequest request,
                                      HttpServletResponse response,
                                      Authentication authentication) throws IOException, ServletException {

      CustomUser customUser = (CustomUser) authentication.getPrincipal();
      Users user = customUser.getUser();

      Long id = user.getId();
      String username = user.getUsername();
      List<String> roles = customUser.getAuthorities()
                              .stream()
                              .map(GrantedAuthority::getAuthority)
                              .collect(Collectors.toList());

      // JWT 생성
      String jwt = jwtProvider.createToken(String.valueOf(id), username, roles);

      // 쿠키 세팅
      ResponseCookie cookie = ResponseCookie.from("jwt", jwt)
                                            .httpOnly(true)
                                            .secure(true)
                                            .path("/")
                                            .maxAge(Duration.ofDays(5))
                                            .sameSite("Strict")
                                            .build();
      response.addHeader(HttpHeaders.SET_COOKIE, cookie.toString());

      // body에 유저 정보 반환
      // response.setContentType("application/json");
      // response.setCharacterEncoding("UTF-8");
      // ObjectMapper objectMapper = new ObjectMapper();
      // response.getWriter().write(objectMapper.writeValueAsString(user));
      // response.setStatus(HttpServletResponse.SC_OK);

      response.sendRedirect("http://localhost:5173/");
  }
}
