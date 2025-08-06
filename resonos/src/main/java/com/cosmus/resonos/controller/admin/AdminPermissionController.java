package com.cosmus.resonos.controller.admin;

import com.cosmus.resonos.domain.user.UserAuth;
import com.cosmus.resonos.domain.user.Users;
import com.cosmus.resonos.service.user.UserService;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class AdminPermissionController {
    private final UserService userService;

    // 권한/역할 관리 페이지
    @GetMapping("/admin/permission")
    public String permissionPage(Model model) throws Exception {
        List<Users> userList = userService.list();
        List<UserAuth> authList = userService.listAuth();
        // 각 User에 권한 매핑
        for (Users user : userList) {
            user.setAuthList(authList.stream().filter(a -> a.getUsername().equals(user.getUsername())).toList());
        }
        model.addAttribute("users", userList);
        return "admin/admin_permission_management";
    }

    // 권한 변경 처리
    @PostMapping("/admin/permission/change")
    public String changePermission(@RequestParam Long userId, @RequestParam String auth) throws Exception {
        // username 조회
        Users user = userService.list().stream().filter(u -> u.getId().equals(userId)).findFirst().orElse(null);
        if (user != null) {
            UserAuth userAuth = new UserAuth();
            userAuth.setUsername(user.getUsername());
            userAuth.setAuth(auth);
            userService.insertAuth(userAuth); // 기존 권한 삭제 후 insert가 필요하다면 서비스에서 처리
        }
        return "redirect:/admin/permission";
    }
}
