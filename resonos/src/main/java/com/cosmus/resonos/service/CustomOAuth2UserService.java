package com.cosmus.resonos.service;

import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.UserAuth;
import com.cosmus.resonos.domain.Users;

import lombok.extern.slf4j.Slf4j;


@Service
@Slf4j
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {

    @Autowired
    private UserService userService;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        // 1. 기본 사용자 정보 조회
        OAuth2User oauth2User = new DefaultOAuth2UserService().loadUser(userRequest);
        Map<String, Object> attributes = oauth2User.getAttributes();

        // 2. 카카오 유저 정보 파싱
        Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
        Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");

        String provider = userRequest.getClientRegistration().getRegistrationId(); // "kakao"
        String providerId = String.valueOf(attributes.get("id"));
        String email = (String) kakaoAccount.get("email");
        String nickname = (String) profile.get("nickname");

        log.info("가져온 카카오 유저 정보 : {}, {}, {}, {}", provider, providerId, email, nickname);

        Users user = null;
        try {
            // 3. DB에서 유저 조회
            user = userService.findByProviderAndProviderId(provider, providerId);

            // 4. 최초 로그인일 경우 회원가입 처리
            if (user == null) {
                user = new Users();
                user.setUsername(UUID.randomUUID() + provider);
                user.setPassword(UUID.randomUUID().toString());
                user.setNickname(UUID.randomUUID() + nickname);
                user.setEmail(email);
                user.setProvider(provider);
                user.setProviderId(providerId);

                boolean result = userService.insertSnsUser(user);
                if(result) {
                    if (result) {
                        UserAuth userAuth = new UserAuth();
                        userAuth.setUsername(user.getUsername());
                        userAuth.setAuth("ROLE_USER"); // 2L = ROLE_USER, 1L = ROLE_ADMIN 등
                        userService.insertAuth(userAuth);
                        log.info("================== 회원가입 완료 ===================");
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        // 5. Spring Security 세션 저장용 객체 리턴
        return new CustomUser(
            user,
            attributes
        );
    }
}
