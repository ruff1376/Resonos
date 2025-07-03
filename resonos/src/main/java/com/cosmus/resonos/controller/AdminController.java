package com.cosmus.resonos.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosmus.resonos.service.BoardPostService;
import com.cosmus.resonos.service.ReportService;
import com.cosmus.resonos.service.UserService;

import groovy.util.logging.Slf4j;



@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ReportService reportService;
    @Autowired private UserService userService;
    @Autowired private BoardPostService boardPostService;

    @GetMapping({"", "/"})
    public String adminMain(Model model) throws Exception {
        int memberCount = userService.countAll(); // 실제 값
        int postCount = boardPostService.countAll(); // 실제 값
        int reportCount = reportService.countAll(); // 실제 값
        int blindCount = reportService.countByBlind(); // 실제 값

        model.addAttribute("memberCount", memberCount); 
        model.addAttribute("postCount", postCount);
        model.addAttribute("reportCount", reportCount); // 나중에 board post의 status로 변경 필요
        model.addAttribute("blindCount", blindCount);

        return "admin/index";
    }

 
    

    
}
