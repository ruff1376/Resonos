package com.cosmus.resonos.util;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.Users;

@ControllerAdvice
public class GlobalPrincipalAdvice {

  // 모든 페이지에서 유저 정보 접근 가능
  // 컨트롤러에서 모델로 user 객체 넘길 필요X
  // 헤더 프로필 이미지 땜에 select 해야 하네 ㅇㄴ
  @ModelAttribute("user")
    public Users getCurrentUser(@AuthenticationPrincipal CustomUser userDetails) {
        return userDetails != null ? userDetails.getUser() : null;
    }
}
