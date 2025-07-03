package com.cosmus.resonos.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import groovy.util.logging.Slf4j;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;
import org.springframework.beans.factory.annotation.Autowired;

import com.cosmus.resonos.service.UserService;

@Slf4j
@Controller
@RequestMapping("/admin/members")
public class AdminMemberController {

    @Autowired
    private UserService userService;

    // 루트 페이지 이동 + 회원 목록 출력
    @GetMapping
    public String index(Model model) throws Exception {
        model.addAttribute("members", userService.list());
        return "/admin/members"; // /admin/members.html
    }
 
    

    
}
