package com.cosmus.resonos.controller;

import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.domain.UserAuth;
import com.cosmus.resonos.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/role")
public class AdminRoleManageController {

    @Autowired
    private UserService userService;


    // 권한 관리 페이지
    @GetMapping
    public String roleManagePage(Model model) throws Exception {
        List<Users> members = userService.list();
        model.addAttribute("members", members);
        return "admin/role"; // /admin/role.html
    }
    // 권한 조회
    @GetMapping("/auth/{username}")
    public String getAuth(@PathVariable String username, Model model) throws Exception {
        List<UserAuth> authList = userService.selectAuthByUsername(username);
        model.addAttribute("authList", authList);
        return "admin/role";
    }
    // 권한 수정
    @PostMapping("/auth/update")
    public String updateAuth(@RequestParam String username, @RequestParam String auth) throws Exception {
        userService.deleteAuthByUsername(username); // 서비스 계층 사용
        UserAuth userAuth = new UserAuth();
        userAuth.setUsername(username);
        userAuth.setAuth(auth);
        userService.insertAuth(userAuth); // 서비스 계층 사용
        return "redirect:/admin/role";
    }
    // 권한 삭제
    @PostMapping("/auth/delete")
    public String deleteAuth(@RequestParam String username, @RequestParam String auth) throws Exception {
        userService.deleteAuthByUsername(username); // 서비스 계층 사용
        return "redirect:/admin/role";
    }
}