package com.cosmus.resonos.service;

import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserRequest;
import org.springframework.security.oauth2.client.oidc.userinfo.OidcUserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.user.UserAuth;
import com.cosmus.resonos.domain.user.Users;
import com.cosmus.resonos.service.user.UserService;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CustomOIDCUserService extends OidcUserService {

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public OidcUser loadUser(OidcUserRequest userRequest) throws OAuth2AuthenticationException {

        log.info("CustomOidcUserService 호출됨");

        OidcUser oidcUser = super.loadUser(userRequest);
        Map<String, Object> attributes = oidcUser.getAttributes();

        String provider = userRequest.getClientRegistration().getRegistrationId();
        String providerId = null;
        String email = null;
        String nickname = null;

        log.info("provider : {}", provider);

        if ("google".equals(provider)) {
            providerId = (String) attributes.get("sub");
            email = (String) attributes.get("email");
            nickname = (String) attributes.get("name");
        } else {
            throw new OAuth2AuthenticationException("지원하지 않는 provider (OIDC): " + provider);
        }

        log.info("가져온 소셜 유저 정보 : {}, {}, {}, {}", provider, providerId, email, nickname);

        Users user = null;
        try {
            // DB에서 유저 조회
            user = userService.findByProviderAndProviderId(provider, providerId);

            // 최초 로그인 시 회원가입 처리
            if (user == null) {
                String randomUn = provider + UUID.randomUUID().toString().substring(0,10);
                user = new Users();
                user.setUsername(randomUn);
                user.setPassword(passwordEncoder.encode(UUID.randomUUID().toString()));
                user.setNickname(nickname + UUID.randomUUID().toString().substring(0, 6));
                user.setEmail(email);
                user.setProvider(provider);
                user.setProviderId(providerId);

                try {
                    boolean result = userService.insertSnsUser(user);
                    if(result) {
                        UserAuth userAuth = new UserAuth();
                        userAuth.setUsername(user.getUsername());
                        userAuth.setAuth("ROLE_USER");
                        userService.insertAuth(userAuth);
                        log.info("================== 구글 회원가입 완료 (OIDC) ===================");
                        user = userService.select(randomUn);
                        userService.basicNotiSetting(user.getId());
                    }
                } catch(DuplicateKeyException e) {
                    throw new OAuth2AuthenticationException(
                        new OAuth2Error("duplicate_email", "이미 가입된 이메일입니다", null)
                    );
                }
            }
        }
        catch(OAuth2AuthenticationException e) {
            throw e;
        }
        catch (Exception e) {
            e.printStackTrace();
            throw new OAuth2AuthenticationException("internal_error");
        }

        return new CustomUser(user, attributes);
    }
}
