package com.cosmus.resonos.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import groovy.util.logging.Slf4j;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.service.UserService;

@Slf4j
@Controller
@RequestMapping("/admin/members")
public class AdminMemberController {

    @Autowired
    private UserService userService;

    // 루트 페이지 이동 + 회원 목록 출력
    @GetMapping
    public String members(@RequestParam(value = "keyword", required = false) String keyword, Model model) throws Exception {
    List<Users> members;
    if (keyword != null && !keyword.isBlank()) {
        members = userService.searchByKeyword(keyword); // 닉네임/이메일 LIKE 검색
    } else {
        members = userService.list();
    }
    model.addAttribute("members", members);
    model.addAttribute("keyword", keyword);
    return "admin/members";
    }




}
