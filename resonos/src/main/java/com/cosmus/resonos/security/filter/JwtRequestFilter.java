package com.cosmus.resonos.security.filter;

import java.io.IOException;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import com.cosmus.resonos.security.contants.SecurityConstants;
import com.cosmus.resonos.security.provider.JwtProvider;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JwtRequestFilter extends OncePerRequestFilter {

  private final AuthenticationManager authenticationManager;
  private final JwtProvider jwtProvider;

  public JwtRequestFilter( AuthenticationManager authenticationManager, JwtProvider jwtProvider ) {
      this.authenticationManager = authenticationManager;
      this.jwtProvider = jwtProvider;
  }

  /**
   * 요청 필터 작업
   * 1. JWT 추출
   * 2. 인증 시도
   * 3. JWT 검증
   *      ⭕ 토큰이 유효하면, 인증 처리 완료
   *      ❌ 토큰이 만료되면, (-)
   * 4. 다음 필터로 진행
  */
  @Override
  protected void doFilterInternal(HttpServletRequest request,
                                  HttpServletResponse response,
                                  FilterChain filterChain)
      throws ServletException, IOException {
    // 1. JWT 추출 (Authorization 헤더 대신 쿠키에서)
    String jwt = null;
    if(request.getCookies() != null) {
      for(Cookie cookie : request.getCookies()) {
        if("jwt".equals(cookie.getName())) {
          jwt = cookie.getValue();
          break;
        }
      }
    }

    if(jwt == null || jwt.isEmpty()) {
      filterChain.doFilter(request, response);
      return;
    }

    // 2. 인증 시도
    Authentication authentication = jwtProvider.getAuthenticationToken(jwt);

    if( authentication != null && authentication.isAuthenticated() ) {
        log.info("JWT 를 통한 인증 완료");
    }

    // 3. 🔍💍 JWT 검증
    boolean result = jwtProvider.validateToken(jwt);

    if( result ) {
        // JWT 토큰이 유효하면, 인증 처리 완료
        log.info("유효한 JWT 토큰 입니다.");
        // SecurityContextHolder    : 사용자 보안정보를 담는 객체 📦
        // Authentication           : 사용자 인증 정보           👩‍💼
        // 📦( 👩‍💼 ) ➡ 로그인
        SecurityContextHolder.getContext().setAuthentication(authentication);
    }

    // 4. 다음 필터로 진행
    filterChain.doFilter(request, response);
  }

}
