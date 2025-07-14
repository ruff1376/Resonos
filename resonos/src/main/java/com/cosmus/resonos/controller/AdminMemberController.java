package com.cosmus.resonos.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import com.cosmus.resonos.domain.Pagination;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.server.ResponseStatusException;

import com.cosmus.resonos.domain.UserActivityLog;
import com.cosmus.resonos.domain.UserAuth;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.service.UserActivityLogService;
import com.cosmus.resonos.service.UserService;

import lombok.extern.slf4j.Slf4j;


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
    public String members(
        @RequestParam(value = "page", defaultValue = "1") long page,
        @RequestParam(value = "size", defaultValue = "10") long size,
        @RequestParam(value = "keyword", required = false) String keyword,
        Model model
    ) throws Exception {
        // 전체 회원 수 (검색 포함)
        long total = (keyword != null && !keyword.isBlank())
            ? userService.countByKeyword(keyword)
            : userService.countAll();

        // Pagination 객체 생성 (페이지, 페이지당 크기, 노출 페이지 수, 전체 개수)
        Pagination pagination = new Pagination(page, size, 10, total);

        // 회원 목록 조회 (검색 & 페이징)
        // index와 size를 그대로 사용
        List<Users> members = (keyword != null && !keyword.isBlank())
            ? userService.searchByKeywordPaging(keyword, (int)pagination.getIndex(), (int)pagination.getSize())
            : userService.listPaging((int)pagination.getIndex(), (int)pagination.getSize());

        // 각 회원의 최근 로그(최신 3개) 조회
        for (Users member : members) {
            List<UserActivityLog> logs = userActivityLogService.getLogsByUserId(member.getId());
            if (logs != null && logs.size() > 3) {
                member.setLogs(logs.subList(0, 3));
            } else {
                member.setLogs(logs);
            }
        }

        // Model에 데이터 전달
        model.addAttribute("members", members);
        model.addAttribute("pagination", pagination);
        model.addAttribute("keyword", keyword);
        model.addAttribute("pageUri", "/admin/members?size=" + size + (keyword != null && !keyword.isBlank() ? "&keyword=" + keyword : ""));

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
        result.put("username", member.getUsername());
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
    @ResponseBody
    public ResponseEntity<?> updateMember(@ModelAttribute Users user) {
        log.info("수정 요청: {}", user); // Users 객체 모든 값 로그로 확인
        try {
            userService.update(user);
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            log.error("회원 수정 오류", e);
            return ResponseEntity.status(500).body("업데이트 실패: " + e.getMessage());
        }
    }
    // 회원 비밀번호 랜덤 초기화
    @PostMapping("/reset-password")
    @ResponseBody
    public Map<String, Object> resetPassword(@RequestParam Long id) {
        Map<String, Object> result = new HashMap<>();
        try {
            String randomPw = RandomStringUtils.randomAlphanumeric(10); // org.apache.commons.lang3
            userService.updatePassword(id, randomPw); // 비밀번호 암호화 후 저장
            result.put("success", true);
            result.put("password", randomPw);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
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


    // 회원 추가 
    @PostMapping("/create")
    @ResponseBody
    public ResponseEntity<?> createMember(@ModelAttribute Users user) throws Exception {
        try {
            userService.join(user); // auth(권한)도 저장
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("회원 등록 실패: " + e.getMessage());
        }
    }








}



