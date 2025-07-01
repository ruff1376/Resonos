package com.cosmus.resonos.controller;

import org.springframework.boot.autoconfigure.graphql.GraphQlProperties.Http;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cosmus.resonos.domain.User;

import lombok.extern.slf4j.Slf4j;



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
  public String edit(Model model) {
    User user = User.builder().nickname("김조김조은").bio("안녕하세요 음악과 우주를 사랑하는 김조은입니다.").email("resonos12@gmail.com").username("김조은").build();
    model.addAttribute("user", user);

    return "user/edit";
  }

  @PostMapping("/edit")
  public ResponseEntity<?> editPost(@ModelAttribute User user) {

    if(user != null) {
      log.info("user : {}", user);
      return new ResponseEntity<>("SUCESS", HttpStatus.OK);
    }

    return new ResponseEntity<>("FAIL", HttpStatus.BAD_REQUEST);
  }
}
