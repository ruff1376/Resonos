package com.cosmus.resonos.security;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.stereotype.Component;

import com.cosmus.resonos.domain.CustomUser;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class OAuth2SuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler  {

  private PersistentTokenBasedRememberMeServices rememberMeServices;

  // 생성자 주입
  public OAuth2SuccessHandler(PersistentTokenBasedRememberMeServices rememberMeServices) {
      this.rememberMeServices = rememberMeServices;
  }

  @Override
  public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
      Authentication authentication) throws IOException, ServletException {
    Object principal = authentication.getPrincipal();
    if (principal instanceof CustomUser) {
        CustomUser user = (CustomUser) principal;
        if (!user.isEnabled()) {
            throw new OAuth2AuthenticationException(new OAuth2Error("user_disabled", "사용자 계정이 비활성화되었습니다.", null));
        }
        System.out.println("여기까지 옴...");
        SecurityContextHolder.getContext().setAuthentication(authentication);
        rememberMeServices.loginSuccess(request, response, authentication);
    }
    getRedirectStrategy().sendRedirect(request, response, "/");
  }
}
