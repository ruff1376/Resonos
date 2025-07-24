package com.cosmus.resonos.controller;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.domain.UserAuth;
import com.cosmus.resonos.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/role")
public class AdminRoleManageController {

    @Autowired
    private UserService userService;

    // 권한 관리 페이지 (페이징 추가)
    @GetMapping
    public String roleManagePage(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            Model model) throws Exception {
        
        // 페이지 번호/사이즈 검증
        if(page < 1) page = 1;
        if(size < 1) size = 10;
        
        // 전체 유저 수 조회
        long total = userService.countAllUsers();
        
        // Pagination 객체 생성 (현재 페이지, 사이즈, 네비게이션 수, 전체 개수)
        Pagination pagination = new Pagination(page, size, 10, total);

        // 페이지 단위로 회원 목록 조회 (offset에서 시작, size만큼 가져옴)
        List<Users> members = userService.listPagingA(pagination.getIndex(), pagination.getSize());

        // 모델에 데이터 세팅
        model.addAttribute("members", members);
        model.addAttribute("pagination", pagination);

        // 페이징 URI: 페이지를 이동할 때 size 파라미터 유지
        String pageUri = "/admin/role?size=" + size;
        model.addAttribute("pageUri", pageUri);

        return "admin/role";  // thymeleaf 뷰 위치
    }

    // 권한 조회 (기존 유지)
    @GetMapping("/auth/{username}")
    public String getAuth(@PathVariable("username") String username, Model model) throws Exception {
        List<UserAuth> authList = userService.selectAuthByUsername(username);
        model.addAttribute("authList", authList);
        return "admin/role";
    }

    // 권한 추가 (기존 유지)
    @PostMapping("/auth/add")
    public String addAuth(@RequestParam("username") String username,
                          @RequestParam("auth") String auth,
                          Model model) throws Exception {
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

    // 권한 삭제 (기존 유지)
    @PostMapping("/auth/delete")
    public String deleteAuth(@RequestParam("username") String username,
                             @RequestParam("auth") String auth) throws Exception {
        userService.deleteSpecificAuth(username, auth);
        return "redirect:/admin/role";
    }

    // 권한 일괄 수정 (기존 유지)
    @PostMapping("/auth/update")
    public String updateAuth(@RequestParam("username") String username,
                             @RequestParam(value = "auths", required = false) List<String> auths) throws Exception {
        userService.deleteAuthByUsername(username);
        if (auths != null) {
            for (String auth : auths) {
                UserAuth userAuth = new UserAuth();
                userAuth.setUsername(username);
                userAuth.setAuth(auth);
                userService.insertAuth(userAuth);
            }
        }
        return "redirect:/admin/role";
    }

    // 권한 토글 (기존 유지)
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
