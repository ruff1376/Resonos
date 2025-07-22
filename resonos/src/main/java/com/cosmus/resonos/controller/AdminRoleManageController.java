package com.cosmus.resonos.controller;

import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.domain.UserAuth;
import com.cosmus.resonos.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

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
    public String getAuth(@PathVariable("username") String username, Model model) throws Exception {
        List<UserAuth> authList = userService.selectAuthByUsername(username);
        model.addAttribute("authList", authList);
        return "admin/role";
    }

    @PostMapping("/auth/add")
    public String addAuth(@RequestParam("username") String username, @RequestParam("auth") String auth, Model model) throws Exception {
        // 이미 권한이 있는지 체크
        boolean exists = userService.hasAuth(username, auth);
        if (!exists) {
            UserAuth userAuth = new UserAuth();
            userAuth.setUsername(username);
            userAuth.setAuth(auth);
            userService.insertAuth(userAuth);
            model.addAttribute("successMessage", "권한이 추가되었습니다.");
        } else {
            model.addAttribute("errorMessage", "이미 존재하는 권한입니다.");
        }
        return "redirect:/admin/role";
    }


    // 권한 삭제 (특정 권한만)
    @PostMapping("/auth/delete")
    public String deleteAuth(@RequestParam("username") String username, @RequestParam("auth") String auth) throws Exception {
        userService.deleteSpecificAuth(username, auth); // 특정 권한만 삭제
        return "redirect:/admin/role";
    }

    // 권한 일괄 수정 (전부 교체가 필요할 때만 사용, 예: 체크박스 일괄 변경)
    @PostMapping("/auth/update")
    public String updateAuth(
            @RequestParam("username") String username,
            @RequestParam(value = "auths", required = false) List<String> auths // 여러 권한
    ) throws Exception {
        userService.deleteAuthByUsername(username); // 기존 권한 모두 삭제
        if (auths != null) {
            for (String auth : auths) {
                UserAuth userAuth = new UserAuth();
                userAuth.setUsername(username);
                userAuth.setAuth(auth);
                userService.insertAuth(userAuth); // 새로운 권한들 추가
            }
        }
        return "redirect:/admin/role";
    }

    // 권한 토글 (예: ROLE_ADMIN만 토글)
    @PostMapping("/auth/toggle")
    @ResponseBody
    public String toggleAdminRole(@RequestBody Map<String, Object> payload) throws Exception {
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
        return "ok";
    }
}
