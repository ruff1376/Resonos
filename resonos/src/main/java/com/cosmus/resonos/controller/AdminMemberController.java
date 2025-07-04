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
import com.cosmus.resonos.domain.UserActivityLog;
import com.cosmus.resonos.service.UserActivityLogService;

@Slf4j
@Controller
@RequestMapping("/admin/members")
public class AdminMemberController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private UserActivityLogService userActivityLogService;

    // 루트 페이지 이동 + 회원 목록 출력
    @GetMapping
    public String members(@RequestParam(value = "keyword", required = false) String keyword, Model model) throws Exception {
    List<Users> members;
    if (keyword != null && !keyword.isBlank()) {
        members = userService.searchByKeyword(keyword); // 닉네임/이메일 LIKE 검색
    } else {
        members = userService.list();
    }
    
    for (Users member : members) {
        List<UserActivityLog> logs = userActivityLogService.getLogsByUserId(member.getId()); // 전체 로그 조회
        // 최근 3개만 추출 (최신순)
        if (logs != null && logs.size() > 3) {
            member.setLogs(logs.subList(0, 3));
        } else {
            member.setLogs(logs);
        }
    }
    model.addAttribute("members", members);
    model.addAttribute("keyword", keyword);
    return "admin/members";
    }
    // 회원 활성/비활성 토글
    @RequestMapping("/enable")
    public String enableMember(@RequestParam("id") Long id, @RequestParam("enabled") boolean enabled, @RequestParam(value = "keyword", required = false) String keyword, Model model) throws Exception {
        userService.enableUser(id, enabled);
        return "redirect:/admin/members" + (keyword != null && !keyword.isBlank() ? ("?keyword=" + keyword) : "");
    }

    // 회원 제재/해제 토글
    @RequestMapping("/ban")
    public String banMember(@RequestParam("id") Long id, @RequestParam("ban") boolean ban, @RequestParam(value = "keyword", required = false) String keyword, Model model) throws Exception {
        userService.banUser(id, ban);
        return "redirect:/admin/members" + (keyword != null && !keyword.isBlank() ? ("?keyword=" + keyword) : "");
    }

    // 회원 전체 로그
    @RequestMapping("/logs")
    public String memberLogs(@RequestParam("userId") Long userId, Model model) throws Exception {
        List<UserActivityLog> logs = userActivityLogService.getLogsByUserId(userId);
        model.addAttribute("logs", logs);
        return "admin/member_log";
    }

}
