package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.UserRole;
import com.cosmus.resonos.service.UserRoleService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user-roles")
public class UserRoleController {

    @Autowired
    private UserRoleService userRoleService;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[UserRoleController] 유저-역할 목록 요청");
        List<UserRole> userRoles = userRoleService.list();
        log.info("[UserRoleController] 유저-역할 수: {}", userRoles.size());
        model.addAttribute("userRoles", userRoles);
        return "userrole/list"; // userrole/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[UserRoleController] 유저-역할 상세 요청 - id: {}", id);
        UserRole userRole = userRoleService.select(id);
        if (userRole == null) {
            log.warn("[UserRoleController] 유저-역할 없음 - id: {}", id);
            return "redirect:/user-roles?error=notfound";
        }
        log.info("[UserRoleController] 유저-역할 상세: {}", userRole);
        model.addAttribute("userRole", userRole);
        return "userrole/detail"; // userrole/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[UserRoleController] 유저-역할 등록 폼 요청");
        model.addAttribute("userRole", new UserRole());
        return "userrole/form"; // userrole/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute UserRole userRole, Model model) throws Exception {
        log.info("[UserRoleController] 유저-역할 등록 시도: {}", userRole);
        boolean success = userRoleService.insert(userRole);
        if (success) {
            log.info("[UserRoleController] 유저-역할 등록 성공: {}", userRole);
            return "redirect:/user-roles";
        }
        log.warn("[UserRoleController] 유저-역할 등록 실패: {}", userRole);
        model.addAttribute("error", "등록 실패");
        return "userrole/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[UserRoleController] 유저-역할 수정 폼 요청 - id: {}", id);
        UserRole userRole = userRoleService.select(id);
        if (userRole == null) {
            log.warn("[UserRoleController] 수정할 유저-역할 없음 - id: {}", id);
            return "redirect:/user-roles?error=notfound";
        }
        model.addAttribute("userRole", userRole);
        return "userrole/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute UserRole userRole, Model model) throws Exception {
        log.info("[UserRoleController] 유저-역할 수정 시도 - id: {}, userRole: {}", id, userRole);
        userRole.setId(id);
        boolean success = userRoleService.update(userRole);
        if (success) {
            log.info("[UserRoleController] 유저-역할 수정 성공 - id: {}", id);
            return "redirect:/user-roles/" + id;
        }
        log.warn("[UserRoleController] 유저-역할 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "userrole/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[UserRoleController] 유저-역할 삭제 시도 - id: {}", id);
        userRoleService.delete(id);
        log.info("[UserRoleController] 유저-역할 삭제 완료 - id: {}", id);
        return "redirect:/user-roles";
    }
}
