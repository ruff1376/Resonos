package com.cosmus.resonos.controller.admin;

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
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.admin.UserActivityLog;
import com.cosmus.resonos.domain.admin.UserSanction;
import com.cosmus.resonos.domain.user.UserAuth;
import com.cosmus.resonos.domain.user.Users;
import com.cosmus.resonos.service.admin.UserActivityLogService;
import com.cosmus.resonos.service.admin.UserSanctionService;
import com.cosmus.resonos.service.user.UserService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin("*")
@RestController
@RequestMapping("/api/admin/members")
public class AdminMemberController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserActivityLogService userActivityLogService;

    @Autowired
    private UserSanctionService userSanctionService;

    // 회원 목록 조회 (page, size, keyword)
    @GetMapping
    public ResponseEntity<?> getMembers(
            @RequestParam(value = "page", defaultValue = "1") long page,
            @RequestParam(value = "size", defaultValue = "10") long size,
            @RequestParam(value = "keyword", defaultValue = "") String keyword) throws Exception{
        try {
            if (page < 1) page = 1;
            if (size < 1) size = 10;

            long total = keyword.isBlank()
                    ? userService.countAll()
                    : userService.countByKeyword(keyword);

            Pagination pagination = new Pagination(page, size, 10, total);

            List<Users> members = keyword.isBlank()
                    ? userService.listPaging((int) pagination.getIndex(), (int) pagination.getSize())
                    : userService.searchByKeywordPaging(keyword, (int) pagination.getIndex(), (int) pagination.getSize());

            members.forEach(member -> {
                try {
                    List<UserActivityLog> logs = userActivityLogService.getLogsByUserId(member.getId());
                    if (logs == null)
                        member.setLogs(List.of());
                    else if (logs.size() > 3)
                        member.setLogs(logs.subList(0, 3));
                    else
                        member.setLogs(logs);
                } catch (Exception ex) {
                    log.error("유저 활동 로그 조회 실패 (userId: " + member.getId() + ")", ex);
                    member.setLogs(List.of());
                }
            });

            Map<String, Object> response = new HashMap<>();
            response.put("members", members);
            response.put("pagination", pagination);
            response.put("keyword", keyword);
            String pageUri = "/api/admin/members?size=" + size;
            if (!keyword.isBlank())
                pageUri += "&keyword=" + URLEncoder.encode(keyword, StandardCharsets.UTF_8);
            response.put("pageUri", pageUri);

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            log.error("회원 목록 조회 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "회원 목록 조회 실패"));
        }
    }

    // 회원 상세 조회
    @GetMapping("/{id}")
    public ResponseEntity<?> getMember(@PathVariable("id") Long id) {
        try {
            Users member = userService.selectById(id);
            if (member == null)
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("error", "회원이 존재하지 않습니다."));

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

            return ResponseEntity.ok(result);
        } catch (Exception e) {
            log.error("회원 상세 조회 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "회원 상세 조회 실패"));
        }
    }

    // 회원 생성
    @PostMapping
    public ResponseEntity<?> createMember(@RequestBody Users user) {
        try {
            userService.join(user);
            return new ResponseEntity<>("SUCCESS", HttpStatus.CREATED);
        } catch (Exception e) {
            log.error("회원 생성 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("회원 등록 실패: " + e.getMessage());
        }
    }

    // 회원 수정
    @PutMapping
    public ResponseEntity<?> updateMember(@RequestBody Users user) {
        try {
            userService.update(user);
            return ResponseEntity.ok("SUCCESS");
        } catch (Exception e) {
            log.error("회원 수정 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("업데이트 실패: " + e.getMessage());
        }
    }

    // 회원 삭제
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteMember(@PathVariable Long id) {
        try {
            userService.delete(id);
            return ResponseEntity.ok("SUCCESS");
        } catch (Exception e) {
            log.error("회원 삭제 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("삭제 실패: " + e.getMessage());
        }
    }

    // 회원 활성/비활성 토글
    @PostMapping("/enable")
    public ResponseEntity<?> enableMember(@RequestParam("id") Long id, @RequestParam("enabled") boolean enabled) {
        try {
            userService.enableUser(id, enabled);
            return ResponseEntity.ok(Map.of("success", true));
        } catch (Exception e) {
            log.error("활성/비활성 토글 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "회원 활성/비활성 변경 실패"));
        }
    }

    // 회원 밴/해제 (관리자 권한 필요)
    @PostMapping("/ban")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<?> banMember(
            @RequestParam("id") Long userId,
            @RequestParam(value = "ban", defaultValue = "true") boolean ban,
            @RequestParam(value = "reason", required = false) String reason,
            Authentication auth) {
        try {
            if (auth == null || auth.getPrincipal() == null)
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("관리자 인증 필요");

            Long adminId = ((com.cosmus.resonos.domain.CustomUser) auth.getPrincipal()).getId();
            if (ban) {
                userSanctionService.banUser(userId, reason, adminId);
            } else {
                userSanctionService.unbanUser(userId, adminId);
            }
            return ResponseEntity.ok(Map.of("success", true));
        } catch (Exception e) {
            log.error("회원 밴/해제 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("error", "회원 제재 변경 실패"));
        }
    }

    // 비밀번호 랜덤 초기화
    @PostMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@RequestParam Long id) {
        try {
            String randomPw = RandomStringUtils.randomAlphanumeric(10);
            userService.updatePassword(id, randomPw);
            return ResponseEntity.ok(Map.of("success", true, "password", randomPw));
        } catch (Exception e) {
            log.error("비밀번호 초기화 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("success", false, "message", e.getMessage()));
        }
    }

}
