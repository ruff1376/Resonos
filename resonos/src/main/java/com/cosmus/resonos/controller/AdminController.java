package com.cosmus.resonos.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cosmus.resonos.service.BoardPostService;
import com.cosmus.resonos.service.ReportService;
import com.cosmus.resonos.service.UserService;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ReportService reportService;
    @Autowired private UserService userService;
    @Autowired private BoardPostService boardPostService;

    @GetMapping("/stats")
    public Map<String, Integer> getAdminStats() throws Exception {
        int memberCount = userService.countAll();
        int postCount = boardPostService.countAll();
        int reportCount = reportService.countAll();
        int blindCount = reportService.countByBlind();

        Map<String, Integer> stats = new HashMap<>();
        stats.put("memberCount", memberCount);
        stats.put("postCount", postCount);
        stats.put("reportCount", reportCount);
        stats.put("blindCount", blindCount);

        return stats;
    }
}