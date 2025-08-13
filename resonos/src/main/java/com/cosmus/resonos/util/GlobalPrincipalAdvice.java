package com.cosmus.resonos.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.user.Users;
import com.cosmus.resonos.service.user.UserService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@ControllerAdvice
public class GlobalPrincipalAdvice {

  @Autowired
  private UserService userService;

  @ModelAttribute("currentUser")
    public Users getCurrentUser(@AuthenticationPrincipal CustomUser loginUser) throws Exception {
      return loginUser != null ? userService.selectById(loginUser.getId()) : null;
    }
}
