package com.cosmus.resonos.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.admin.AdminLog;
import com.cosmus.resonos.service.admin.AdminLogService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin-logs")
public class AdminLogController {

    @Autowired
    private AdminLogService adminLogService;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[AdminLogController] 로그 목록 요청");
        List<AdminLog> logs = adminLogService.list();
        log.info("[AdminLogController] 로그 수: {}", logs.size());
        model.addAttribute("logs", logs);
        return "adminlog/list"; // adminlog/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[AdminLogController] 로그 상세 요청 - id: {}", id);
        AdminLog logItem = adminLogService.select(id);
        if (logItem == null) {
            log.warn("[AdminLogController] 로그 없음 - id: {}", id);
            return "redirect:/admin-logs?error=notfound";
        }
        log.info("[AdminLogController] 로그 상세: {}", logItem);
        model.addAttribute("log", logItem);
        return "adminlog/detail"; // adminlog/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[AdminLogController] 로그 등록 폼 요청");
        model.addAttribute("log", new AdminLog());
        return "adminlog/form"; // adminlog/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute AdminLog logItem, Model model) throws Exception {
        log.info("[AdminLogController] 로그 등록 시도: {}", logItem);
        boolean success = adminLogService.insert(logItem);
        if (success) {
            log.info("[AdminLogController] 로그 등록 성공: {}", logItem);
            return "redirect:/admin-logs";
        }
        log.warn("[AdminLogController] 로그 등록 실패: {}", logItem);
        model.addAttribute("error", "등록 실패");
        return "adminlog/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[AdminLogController] 로그 수정 폼 요청 - id: {}", id);
        AdminLog logItem = adminLogService.select(id);
        if (logItem == null) {
            log.warn("[AdminLogController] 수정할 로그 없음 - id: {}", id);
            return "redirect:/admin-logs?error=notfound";
        }
        model.addAttribute("log", logItem);
        return "adminlog/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute AdminLog logItem, Model model) throws Exception {
        log.info("[AdminLogController] 로그 수정 시도 - id: {}, log: {}", id, logItem);
        logItem.setId(id);
        boolean success = adminLogService.update(logItem);
        if (success) {
            log.info("[AdminLogController] 로그 수정 성공 - id: {}", id);
            return "redirect:/admin-logs/" + id;
        }
        log.warn("[AdminLogController] 로그 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "adminlog/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[AdminLogController] 로그 삭제 시도 - id: {}", id);
        adminLogService.delete(id);
        log.info("[AdminLogController] 로그 삭제 완료 - id: {}", id);
        return "redirect:/admin-logs";
    }
}
