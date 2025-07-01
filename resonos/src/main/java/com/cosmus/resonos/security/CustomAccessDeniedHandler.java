package com.cosmus.resonos.security;

import java.io.IOException;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

    @Override
    public void handle(HttpServletRequest request
                     , HttpServletResponse response
                     , AccessDeniedException accessDeniedException) throws IOException, ServletException {
        log.info("접근 권한이 없습니다.");

        // 에러 페이지로 이동
        response.sendRedirect("/error/403");
    }

}
