package com.cosmus.resonos.service;

import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
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

    @Autowired PasswordEncoder passwordEncoder;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {

        log.info("호출됨");

        OAuth2User oauth2User = new DefaultOAuth2UserService().loadUser(userRequest);
        Map<String, Object> attributes = oauth2User.getAttributes();

        String provider = userRequest.getClientRegistration().getRegistrationId();
        String providerId = null;
        String email = null;
        String nickname = null;

        log.info("provider : {}", provider);

        if ("kakao".equals(provider)) {
            Map<String, Object> kakaoAccount = (Map<String, Object>) attributes.get("kakao_account");
            Map<String, Object> profile = (Map<String, Object>) kakaoAccount.get("profile");

            providerId = String.valueOf(attributes.get("id"));
            email = (String) kakaoAccount.get("email");
            nickname = (String) profile.get("nickname");

        } else if ("naver".equals(provider)) {
            Map<String, Object> response = (Map<String, Object>) attributes.get("response");

            providerId = (String) response.get("id");
            email = (String) response.get("email");
            nickname = (String) response.get("nickname");

        }

        else {
            throw new OAuth2AuthenticationException("지원하지 않는 provider: " + provider);
        }

        log.info("가져온 소셜 유저 정보 : {}, {}, {}, {}", provider, providerId, email, nickname);

        Users user = null;
        try {
            // DB에서 유저 조회
            user = userService.findByProviderAndProviderId(provider, providerId);

            // 최초 로그인일 경우 회원가입 처리
            if (user == null) {
                String randomUn = provider + UUID.randomUUID().toString().substring(0,10);
                user = new Users();
                user.setUsername(randomUn);
                user.setPassword(passwordEncoder.encode(UUID.randomUUID().toString()));
                user.setNickname(nickname + UUID.randomUUID().toString().substring(0, 6));
                user.setEmail(email);
                user.setProvider(provider);
                user.setProviderId(providerId);

                boolean result = userService.insertSnsUser(user);
                if(result) {
                    UserAuth userAuth = new UserAuth();
                    userAuth.setUsername(user.getUsername());
                    userAuth.setAuth("ROLE_USER");
                    userService.insertAuth(userAuth);
                    log.info("================== 소셜 회원가입 완료 ===================");
                    user = userService.select(randomUn);
                    userService.basicNotiSetting(user.getId());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return new CustomUser(user, attributes);
    }
}
