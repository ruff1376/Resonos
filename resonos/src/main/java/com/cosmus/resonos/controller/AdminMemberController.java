package com.cosmus.resonos.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.server.ResponseStatusException;

import lombok.extern.slf4j.Slf4j;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.ui.Model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.service.UserService;
import com.cosmus.resonos.domain.UserActivityLog;
import com.cosmus.resonos.domain.UserAuth;
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
    // 회원 상세 정보 페이지
    @GetMapping("/{id}/detail-json")
    @ResponseBody
    public Map<String, Object> memberDetailJson(@PathVariable("id") Long id) throws Exception {
        Users member = userService.selectById(id);
        if (member == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "회원 정보를 찾을 수 없습니다.");
        }
        Map<String, Object> result = new HashMap<>();
        result.put("id", member.getId());
        result.put("nickname", member.getNickname());
        result.put("email", member.getEmail());
        result.put("enabled", member.isEnabled());
        result.put("profileImage", member.getProfileImage());
        result.put("authList", member.getAuthList().stream().map(UserAuth::getAuth).collect(Collectors.toList()));
        return result;
    }


    // 회원 정보 수정 (업데이트)
    @PostMapping("/update")
    @ResponseBody // AJAX라면 ResponseBody, 아니면 redirect 등 처리
    public ResponseEntity<?> updateMember(@ModelAttribute Users user) {
        log.info("Updating user: {}", user.getId());
        try {
            userService.update(user); // 실제 수정 로직
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("업데이트 실패: " + e.getMessage());
        }
    }

    // 회원 삭제 
    @PostMapping("/delete")
    @ResponseBody
    public ResponseEntity<?> deleteMember(@RequestParam("id") Long id) {
        log.info("Deleting user: {}", id);
        try {
            userService.delete(id); // 실제 삭제 로직
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("삭제 실패: " + e.getMessage());
        }
    }








}



