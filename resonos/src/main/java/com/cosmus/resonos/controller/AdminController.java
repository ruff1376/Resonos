package com.cosmus.resonos.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import groovy.util.logging.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @GetMapping("/")
    public String admin() {
        return "/admin/index";
    }
    
}
