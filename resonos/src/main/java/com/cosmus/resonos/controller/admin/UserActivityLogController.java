package com.cosmus.resonos.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.user.UserActivityLog;
import com.cosmus.resonos.service.admin.UserActivityLogService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user-activity-logs")
public class UserActivityLogController {

    @Autowired
    private UserActivityLogService userActivityLogService;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[UserActivityLogController] 활동 로그 목록 요청");
        List<UserActivityLog> logs = userActivityLogService.list();
        log.info("[UserActivityLogController] 로그 수: {}", logs.size());
        model.addAttribute("logs", logs);
        return "useractivitylog/list"; // useractivitylog/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[UserActivityLogController] 활동 로그 상세 요청 - id: {}", id);
        UserActivityLog logItem = userActivityLogService.select(id);
        if (logItem == null) {
            log.warn("[UserActivityLogController] 로그 없음 - id: {}", id);
            return "redirect:/user-activity-logs?error=notfound";
        }
        log.info("[UserActivityLogController] 로그 상세: {}", logItem);
        model.addAttribute("log", logItem);
        return "useractivitylog/detail"; // useractivitylog/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[UserActivityLogController] 활동 로그 등록 폼 요청");
        model.addAttribute("log", new UserActivityLog());
        return "useractivitylog/form"; // useractivitylog/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute UserActivityLog logItem, Model model) throws Exception {
        log.info("[UserActivityLogController] 활동 로그 등록 시도: {}", logItem);
        boolean success = userActivityLogService.insert(logItem);
        if (success) {
            log.info("[UserActivityLogController] 활동 로그 등록 성공: {}", logItem);
            return "redirect:/user-activity-logs";
        }
        log.warn("[UserActivityLogController] 활동 로그 등록 실패: {}", logItem);
        model.addAttribute("error", "등록 실패");
        return "useractivitylog/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[UserActivityLogController] 활동 로그 수정 폼 요청 - id: {}", id);
        UserActivityLog logItem = userActivityLogService.select(id);
        if (logItem == null) {
            log.warn("[UserActivityLogController] 수정할 로그 없음 - id: {}", id);
            return "redirect:/user-activity-logs?error=notfound";
        }
        model.addAttribute("log", logItem);
        return "useractivitylog/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute UserActivityLog logItem, Model model) throws Exception {
        log.info("[UserActivityLogController] 활동 로그 수정 시도 - id: {}, log: {}", id, logItem);
        logItem.setId(id);
        boolean success = userActivityLogService.update(logItem);
        if (success) {
            log.info("[UserActivityLogController] 활동 로그 수정 성공 - id: {}", id);
            return "redirect:/user-activity-logs/" + id;
        }
        log.warn("[UserActivityLogController] 활동 로그 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "useractivitylog/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[UserActivityLogController] 활동 로그 삭제 시도 - id: {}", id);
        userActivityLogService.delete(id);
        log.info("[UserActivityLogController] 활동 로그 삭제 완료 - id: {}", id);
        return "redirect:/user-activity-logs";
    }
}
