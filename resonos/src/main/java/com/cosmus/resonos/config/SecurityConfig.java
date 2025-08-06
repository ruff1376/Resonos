package com.cosmus.resonos.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import com.cosmus.resonos.security.CustomAccessDeniedHandler;
import com.cosmus.resonos.security.LoginFailureHandler;
import com.cosmus.resonos.security.LoginSuccessHandler;
import com.cosmus.resonos.security.OAuth2FailureHandler;
import com.cosmus.resonos.security.OAuth2SuccessHandler;
import com.cosmus.resonos.security.filter.JwtAuthenticationFilter;
import com.cosmus.resonos.security.filter.JwtRequestFilter;
import com.cosmus.resonos.security.provider.JwtProvider;
import com.cosmus.resonos.service.CustomOAuth2UserService;
import com.cosmus.resonos.service.CustomOIDCUserService;
import com.cosmus.resonos.service.UserDetailServiceImpl;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity  // 해당 클래스를 스프링 시큐리티 설정 빈으로 등록
                    // @Secured / @PreAuthorized, @PostAuthorized 으로 메서드 권한 제어 활성화
@EnableMethodSecurity(securedEnabled = true, prePostEnabled = true)
public class SecurityConfig {

    @Autowired
    private CustomOAuth2UserService customOAuth2UserService;

    @Autowired
    private CustomOIDCUserService customOidcUserService;

    @Autowired
    private DataSource dataSource;

    // @Autowired
    // private PasswordEncoder passwordEncoder;

    @Autowired
    private UserDetailServiceImpl userDetailServiceImpl;

    @Autowired
    private LoginSuccessHandler loginSuccessHandler;

    @Autowired
    private LoginFailureHandler loginFailureHandler;

    @Autowired
    private CustomAccessDeniedHandler customAccessDeniedHandler;

    @Autowired
    private OAuth2FailureHandler oauth2FailureHandler;

    @Autowired
    private JwtProvider jwtProvider;

    // 🔐 스프링 시큐리티 설정 메소드
	@Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, OAuth2SuccessHandler oauth2SuccessHandler, AuthenticationManager authenticationManager) throws Exception {

        // http.userDetailsService(userDetailServiceImpl);
        // // ✅ 인가 설정

        // http.authorizeHttpRequests(auth -> auth
        //                         .requestMatchers("/admin", "/admin/**").hasRole("ADMIN")
        //                         .requestMatchers("/user", "/user/**").hasAnyRole("USER","ADMIN")
        //                         .requestMatchers("/**").permitAll()
        //                         .anyRequest().permitAll()
        //                         );

        // 폼 기반 로그인 비활성화
		http.formLogin(login ->login.disable());

		// HTTP 기본 인증 비활성화
		http.httpBasic(basic ->basic.disable());

		// CSRF(Cross-Site Request Forgery) 공격 방어 기능 비활성화
		http.csrf(csrf ->csrf.disable());

        // 필터 설정
		// ✅ JWT 요청 필터 설정 1️⃣
		// ✅ JWT 인증 필터 설정 2️⃣
		http.addFilterAt( new JwtAuthenticationFilter(authenticationManager, jwtProvider)
                        , UsernamePasswordAuthenticationFilter.class )
            .addFilterBefore(new JwtRequestFilter(authenticationManager, jwtProvider)
                        , UsernamePasswordAuthenticationFilter.class);

        // 🔐 폼 로그인
        // http.formLogin(login -> login.permitAll());

        // ✅ 커스텀 로그인 페이지
        // http.formLogin(login -> login
        //                             .usernameParameter("username")
        //                             .passwordParameter("password")
        //                             .loginPage("/login")                   // 로그인 페이지 경로
        //                             .loginProcessingUrl("/login") // 로그인 요청 경로
        //                             .successHandler(loginSuccessHandler)      // 로그인 성공 핸들러 설정
        //                             .failureHandler(loginFailureHandler)      // 로그인 실패 핸들러 설정

        //                 );

        http.oauth2Login(login -> login
                                    .loginPage("/login")
                                    .userInfoEndpoint(userInfo -> userInfo
                                    .oidcUserService(customOidcUserService)
                                    .userService(customOAuth2UserService)
                                    )
                                    .successHandler(oauth2SuccessHandler)
                                    .failureHandler(oauth2FailureHandler)
                                );
        // 🔐 인증 요청 경로 설정
        http.exceptionHandling( exception -> exception
                                            // 예외 처리 페이지 설정
                                            // .accessDeniedPage("/exception")
                                            // 접근 거부 핸들러 설정
                                            .accessDeniedHandler(customAccessDeniedHandler)

                                );

        // 🔄 자동 로그인
        http.rememberMe(rm -> rm
            .key("resonos-remember-me-key")
            .tokenRepository(tokenRepository())
            .userDetailsService(userDetailServiceImpl)
            .tokenValiditySeconds(60 * 60 * 24 * 7)
        );

        // 🔓 로그아웃 설정
        http.logout(logout -> logout
                            .logoutUrl("/logout")   // 로그아웃 요청 경로
                            .logoutSuccessUrl("/login?logout=true") // 로그아웃 성공 시 URL
                            .invalidateHttpSession(true)        // 세션 초기화
                            .deleteCookies("remember-id")       // 로그아웃 시, 아이디저장 쿠키 삭제
                            // .logoutSuccessHandler(null)         // 로그아웃 성공 핸들러 설정
                    );

        return http.build();
    }

    // PersistentRepository 토큰정보 객체 - 빈 등록
    @Bean
    public PersistentTokenRepository tokenRepository() {
        // JdbcTokenRepositoryImpl : 토큰 저장 데이터 베이스를 등록하는 객체
        JdbcTokenRepositoryImpl repositoryImpl = new JdbcTokenRepositoryImpl();
        // 토큰 저장소를 사용하는 데이터 소스 지정
        repositoryImpl.setDataSource(dataSource);
        // persistent_logins 테이블 자동 생성
        // repositoryImpl.setCreateTableOnStartup(true);
        try {
            repositoryImpl.getJdbcTemplate().execute(JdbcTokenRepositoryImpl.CREATE_TABLE_SQL);
        } catch (Exception e) {
            log.error("persistent_logins 테이블이 이미 생성되었습니다.");
        }
        return repositoryImpl;
    }


    // 👮‍♂️🔐사용자 인증 관리 메소드
    // 인메모리 방식으로 인증
    // @Bean
    // public UserDetailsService userDetailsService() {
    //     // user 123456
    //     UserDetails user = User.builder()
    //                             .username("user")
    //                             .password(passwordEncoder.encode("123456"))
    //                             .roles("USER")
    //                             .build();
    //     // admin 123456
    //     UserDetails admin = User.builder()
    //                             .username("admin")
    //                             .password(passwordEncoder.encode("123456"))
    //                             .roles("USER", "ADMIN")
    //                             .build();

    //     return new InMemoryUserDetailsManager( user, admin );
    //     // return new JdbcUserDetailsManager( ... );
    // }


    /**
     * 🍃 JDBC 인증 방식 빈 등록
     * @return
     */
    // @Bean
    // public UserDetailsService userDetailsService() {
    //     JdbcUserDetailsManager userDetailsManager
    //             = new JdbcUserDetailsManager(dataSource);

    //     // 사용자 인증 쿼리
    //     String sql1 = " SELECT username, password, enabled "
    //                 + " FROM user "
    //                 + " WHERE username = ? "
    //                 ;
    //     // 사용자 권한 쿼리
    //     String sql2 = " SELECT username, auth "
    //                 + " FROM user_auth "
    //                 + " WHERE username = ? "
    //                 ;
    //     userDetailsManager.setUsersByUsernameQuery(sql1);
    //     userDetailsManager.setAuthoritiesByUsernameQuery(sql2);
    //     return userDetailsManager;
    // }


    /**
     * 🍃 AuthenticationManager 인증 관리자 빈 등록
     * @param authenticationConfiguration
     * @return
     * @throws Exception
    */
    @Bean
    public AuthenticationManager authenticationManager(
                                    AuthenticationConfiguration authenticationConfiguration ) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    @Bean
    public PersistentTokenBasedRememberMeServices rememberMeServices(UserDetailsService userDetailsService, PersistentTokenRepository tokenRepository) {
        PersistentTokenBasedRememberMeServices services =
            new PersistentTokenBasedRememberMeServices("resonos-remember-me-key", userDetailsService, tokenRepository);
            services.setAlwaysRemember(true);
        return services;
    }

    @Bean
    public OAuth2SuccessHandler oauth2SuccessHandler(PersistentTokenBasedRememberMeServices rememberMeServices) {
        return new OAuth2SuccessHandler(rememberMeServices);
    }
}
