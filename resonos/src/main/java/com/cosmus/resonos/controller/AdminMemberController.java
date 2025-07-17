package com.cosmus.resonos.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.server.ResponseStatusException;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.UserActivityLog;
import com.cosmus.resonos.domain.UserAuth;
import com.cosmus.resonos.domain.UserSanction;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.service.UserActivityLogService;
import com.cosmus.resonos.service.UserSanctionService;
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

    @Autowired
    private UserSanctionService userSanctionService;


@GetMapping
public String members(
    @RequestParam(value = "page", defaultValue = "1") long page,
    @RequestParam(value = "size", defaultValue = "10") long size,
    @RequestParam(value = "keyword", required = false) String keyword,
    Model model
) throws Exception {
    // 1. 파라미터 보정 (최소값 보장)
    if (page < 1) page = 1;
    if (size < 1) size = 10;

    // 2. keyword 비어있을 때 ""로 보정 (폼, data-keyword 등에서 안전)
    if (keyword == null) keyword = "";

    // 3. 전체 회원 수
    long total = (!keyword.isBlank())
        ? userService.countByKeyword(keyword)
        : userService.countAll();

    // 4. Pagination 객체 생성
    Pagination pagination = new Pagination(page, size, 10, total);

    // 5. 회원 목록 조회
    List<Users> members = (!keyword.isBlank())
        ? userService.searchByKeywordPaging(keyword, (int)pagination.getIndex(), (int)pagination.getSize())
        : userService.listPaging((int)pagination.getIndex(), (int)pagination.getSize());

    // 6. 각 회원의 최근 로그(최신 3개까지) 조회
    for (Users member : members) {
        List<UserActivityLog> logs = userActivityLogService.getLogsByUserId(member.getId());
        if (logs == null) {
            member.setLogs(List.of());
        } else if (logs.size() > 3) {
            member.setLogs(logs.subList(0, 3));
        } else {
            member.setLogs(logs);
        }
    }

    // 7. Model에 데이터 전달 (keyword 파라미터 누락/불능 방지)
    model.addAttribute("members", members);
    model.addAttribute("pagination", pagination);
    model.addAttribute("keyword", keyword); // null 보정됨
    String pageUri = "/admin/members?size=" + size;
    if (!keyword.isBlank()) {
        pageUri += "&keyword=" + URLEncoder.encode(keyword, StandardCharsets.UTF_8);
    }
    model.addAttribute("pageUri", pageUri);

    return "admin/members";
}



    // 회원 활성/비활성 토글
    @RequestMapping("/enable")
    public String enableMember(@RequestParam("id") Long id, @RequestParam("enabled") boolean enabled, @RequestParam(value = "keyword", required = false) String keyword, Model model) throws Exception {
        userService.enableUser(id, enabled);
        return "redirect:/admin/members" + (keyword != null && !keyword.isBlank() ? ("?keyword=" + keyword) : "");
    }


    
    // 관리자만 접근 가능하게 권한 어노테이션 적용
    @PostMapping("/ban")
    @PreAuthorize("hasRole('ADMIN')")
    public String banMember(
        @RequestParam("id") Long userId,
        @RequestParam(value = "ban", required = false, defaultValue = "true") boolean ban,
        @RequestParam(value = "reason", required = false) String reason,
        @RequestParam(value = "keyword", required = false) String keyword,
        Authentication auth
    ) throws Exception {
        // 인증 객체가 null일 수 있으므로 반드시 null 체크
        if (auth == null || auth.getPrincipal() == null) {
            // 인증 실패 또는 세션 만료 시 처리 (에러 페이지 안내 등)
            throw new IllegalStateException("관리자 인증이 필요합니다. 다시 로그인 후 시도해주세요.");
        }
        Long adminId = ((CustomUser) auth.getPrincipal()).getId();
        // ban = true(제재), ban = false(해제) 분기
        if (ban) {
            userSanctionService.banUser(userId, reason, adminId);
        } else {
            userSanctionService.unbanUser(userId, adminId);
        }
        return "redirect:/admin/members" +
            (keyword != null && !keyword.isBlank() ? ("?keyword=" + keyword) : "");
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
        List<UserSanction> sanctions = userSanctionService.getSanctionsByUserId(id);
        result.put("sanctions", sanctions);
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



