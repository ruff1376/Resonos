package com.cosmus.resonos.controller.admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.admin.Badge;
import com.cosmus.resonos.service.badge.BadgeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/badges")
public class BadgeController {

    @Autowired
    private BadgeService badgeService;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[BadgeController] 뱃지 목록 요청");
        List<Badge> badges = badgeService.list();
        log.info("[BadgeController] 뱃지 수: {}", badges.size());
        model.addAttribute("badges", badges);
        return "badge/list"; // badge/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[BadgeController] 뱃지 상세 요청 - id: {}", id);
        Badge badge = badgeService.select(id);
        if (badge == null) {
            log.warn("[BadgeController] 뱃지 없음 - id: {}", id);
            return "redirect:/badges?error=notfound";
        }
        log.info("[BadgeController] 뱃지 상세: {}", badge);
        model.addAttribute("badge", badge);
        return "badge/detail"; // badge/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[BadgeController] 뱃지 등록 폼 요청");
        model.addAttribute("badge", new Badge());
        return "badge/form"; // badge/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute Badge badge, Model model) throws Exception {
        log.info("[BadgeController] 뱃지 등록 시도: {}", badge);
        boolean success = badgeService.insert(badge);
        if (success) {
            log.info("[BadgeController] 뱃지 등록 성공: {}", badge);
            return "redirect:/badges";
        }
        log.warn("[BadgeController] 뱃지 등록 실패: {}", badge);
        model.addAttribute("error", "등록 실패");
        return "badge/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[BadgeController] 뱃지 수정 폼 요청 - id: {}", id);
        Badge badge = badgeService.select(id);
        if (badge == null) {
            log.warn("[BadgeController] 수정할 뱃지 없음 - id: {}", id);
            return "redirect:/badges?error=notfound";
        }
        model.addAttribute("badge", badge);
        return "badge/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute Badge badge, Model model) throws Exception {
        log.info("[BadgeController] 뱃지 수정 시도 - id: {}, badge: {}", id, badge);
        badge.setId(id);
        boolean success = badgeService.update(badge);
        if (success) {
            log.info("[BadgeController] 뱃지 수정 성공 - id: {}", id);
            return "redirect:/badges/" + id;
        }
        log.warn("[BadgeController] 뱃지 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "badge/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[BadgeController] 뱃지 삭제 시도 - id: {}", id);
        badgeService.delete(id);
        log.info("[BadgeController] 뱃지 삭제 완료 - id: {}", id);
        return "redirect:/badges";
    }
}
