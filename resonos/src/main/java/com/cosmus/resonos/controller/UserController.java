package com.cosmus.resonos.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cosmus.resonos.domain.User;

import groovy.util.logging.Slf4j;




@Slf4j
@Controller
@RequestMapping("/user")
public class UserController {

  @PostMapping("/login")
  public String login(@RequestParam String param) {
      return new String();
  }

  @GetMapping("/mypage")
  // security 활성화 하면
  // public String mypage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
  public String mypage(Model model) {
    User user = User.builder().email("resonos12@gmail.com").username("김조은").build();

    model.addAttribute("user", user);
    return "user/mypage";
  }

  @GetMapping("/edit")
  public String edit() {
    return "user/edit";
  }
}
