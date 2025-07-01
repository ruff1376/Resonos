package com.cosmus.resonos.controller;

import org.springframework.stereotype.Controller;

import groovy.util.logging.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Slf4j
@Controller
public class UserController {

  @GetMapping("/login")
  public String login() {
    return "user/login";
  }
}
