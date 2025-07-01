package com.cosmus.resonos.controller;

import org.springframework.stereotype.Controller;

import groovy.util.logging.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;



@Slf4j
@Controller
@RequestMapping("/user")
public class UserController {

  @PostMapping("/login")
  public String getMethodName(@RequestParam String param) {
      return new String();
  }
}
