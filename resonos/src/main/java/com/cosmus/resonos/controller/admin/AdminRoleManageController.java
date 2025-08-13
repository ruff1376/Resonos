package com.cosmus.resonos.controller.admin;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.user.UserAuth;
import com.cosmus.resonos.domain.user.Users;
import com.cosmus.resonos.service.user.UserService;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@CrossOrigin("*")
@RestController
@RequestMapping("/admin/role")
public class AdminRoleManageController {

    @Autowired
    private UserService userService;

    // 회원 목록 + 페이지네이션
    @GetMapping
    public ResponseEntity<Map<String, Object>> list(
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "size", defaultValue = "10") int size) throws Exception {

        if (page < 1) page = 1;
        if (size < 1) size = 10;

        long total = userService.countAllUsers();
        Pagination pagination = new Pagination(page, size, 10, total);
        List<Users> members = userService.listPagingA(pagination.getIndex(), pagination.getSize());

        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        res.put("members", members);
        res.put("pagination", pagination);
        return ResponseEntity.ok(res);
    }

    // 특정 유저 권한 목록 조회
    @GetMapping("/auth/{username}")
    public ResponseEntity<Map<String, Object>> getAuth(
            @PathVariable(name = "username") String username) throws Exception {
        List<UserAuth> authList = userService.selectAuthByUsername(username);
        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        res.put("authList", authList);
        return ResponseEntity.ok(res);
    }

    // 권한 추가
    @PostMapping("/auth")
    public ResponseEntity<Map<String, Object>> addAuth(
            @RequestBody Map<String, String> payload) throws Exception {
        String username = payload.get("username");
        String auth = payload.get("auth");

        Map<String, Object> res = new HashMap<>();
        boolean exists = userService.hasAuth(username, auth);
        if (!exists) {
            UserAuth userAuth = new UserAuth();
            userAuth.setUsername(username);
            userAuth.setAuth(auth);
            userService.insertAuth(userAuth);
            res.put("success", true);
            res.put("message", "권한이 추가되었습니다.");
        } else {
            res.put("success", false);
            res.put("message", "이미 존재하는 권한입니다.");
        }
        return ResponseEntity.ok(res);
    }

    // 권한 삭제
    @DeleteMapping("/auth")
    public ResponseEntity<Map<String, Object>> deleteAuth(
            @RequestBody Map<String, String> payload) throws Exception {
        String username = payload.get("username");
        String auth = payload.get("auth");
        userService.deleteSpecificAuth(username, auth);
        return ResponseEntity.ok(Map.of("success", true));
    }

    // 권한 일괄 수정
    @PutMapping("/auth")
    public ResponseEntity<Map<String, Object>> updateAuth(
            @RequestBody Map<String, Object> payload) throws Exception {
        String username = (String) payload.get("username");
        @SuppressWarnings("unchecked")
        List<String> auths = (List<String>) payload.get("auths");

        userService.deleteAuthByUsername(username);
        if (auths != null) {
            for (String auth : auths) {
                UserAuth userAuth = new UserAuth();
                userAuth.setUsername(username);
                userAuth.setAuth(auth);
                userService.insertAuth(userAuth);
            }
        }
        return ResponseEntity.ok(Map.of("success", true));
    }

    // 권한 토글 (ROLE_ADMIN)
    @PostMapping("/auth/toggle")
    public ResponseEntity<Map<String, Object>> toggleAdminRole(
            @RequestBody Map<String, Object> payload) throws Exception {
        String username = (String) payload.get("username");
        boolean grant = (Boolean) payload.get("grant");
        if (grant) {
            UserAuth userAuth = new UserAuth();
            userAuth.setUsername(username);
            userAuth.setAuth("ROLE_ADMIN");
            userService.insertAuth(userAuth);
        } else {
            userService.deleteSpecificAuth(username, "ROLE_ADMIN");
        }
        return ResponseEntity.ok(Map.of("success", true));
    }
}
