package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Role;
import com.cosmus.resonos.service.RoleService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/roles")
public class RoleController {

    @Autowired
    private RoleService roleService;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[RoleController] 역할 목록 요청");
        List<Role> roles = roleService.list();
        log.info("[RoleController] 역할 수: {}", roles.size());
        model.addAttribute("roles", roles);
        return "role/list"; // role/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[RoleController] 역할 상세 요청 - id: {}", id);
        Role role = roleService.select(id);
        if (role == null) {
            log.warn("[RoleController] 역할 없음 - id: {}", id);
            return "redirect:/roles?error=notfound";
        }
        log.info("[RoleController] 역할 상세: {}", role);
        model.addAttribute("role", role);
        return "role/detail"; // role/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[RoleController] 역할 등록 폼 요청");
        model.addAttribute("role", new Role());
        return "role/form"; // role/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute Role role, Model model) throws Exception {
        log.info("[RoleController] 역할 등록 시도: {}", role);
        boolean success = roleService.insert(role);
        if (success) {
            log.info("[RoleController] 역할 등록 성공: {}", role);
            return "redirect:/roles";
        }
        log.warn("[RoleController] 역할 등록 실패: {}", role);
        model.addAttribute("error", "등록 실패");
        return "role/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[RoleController] 역할 수정 폼 요청 - id: {}", id);
        Role role = roleService.select(id);
        if (role == null) {
            log.warn("[RoleController] 수정할 역할 없음 - id: {}", id);
            return "redirect:/roles?error=notfound";
        }
        model.addAttribute("role", role);
        return "role/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute Role role, Model model) throws Exception {
        log.info("[RoleController] 역할 수정 시도 - id: {}, role: {}", id, role);
        role.setId(id);
        boolean success = roleService.update(role);
        if (success) {
            log.info("[RoleController] 역할 수정 성공 - id: {}", id);
            return "redirect:/roles/" + id;
        }
        log.warn("[RoleController] 역할 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "role/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[RoleController] 역할 삭제 시도 - id: {}", id);
        roleService.delete(id);
        log.info("[RoleController] 역할 삭제 완료 - id: {}", id);
        return "redirect:/roles";
    }
}
