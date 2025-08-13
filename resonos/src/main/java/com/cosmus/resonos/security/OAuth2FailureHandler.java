package com.cosmus.resonos.security;
import java.io.IOException;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class OAuth2FailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request,
                                        HttpServletResponse response,
                                        AuthenticationException exception)
            throws IOException, ServletException {

        String errorCode = "oauth2_error";

        if (exception instanceof OAuth2AuthenticationException oauth2Ex) {
            errorCode = oauth2Ex.getError().getErrorCode();
        }

        response.sendRedirect("http://localhost:5173/login?error=" + errorCode);
    }
}
