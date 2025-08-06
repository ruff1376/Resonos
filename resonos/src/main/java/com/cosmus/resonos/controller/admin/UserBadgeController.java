package com.cosmus.resonos.controller.admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.user.UserBadge;
import com.cosmus.resonos.service.admin.UserBadgeService;
import com.cosmus.resonos.service.badge.BadgeGrantService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user-badges")
public class UserBadgeController {

    @Autowired
    private UserBadgeService userBadgeService;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[UserBadgeController] 유저 뱃지 목록 요청");
        List<UserBadge> userBadges = userBadgeService.list();
        log.info("[UserBadgeController] 유저 뱃지 수: {}", userBadges.size());
        model.addAttribute("userBadges", userBadges);
        return "userbadge/list"; // userbadge/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[UserBadgeController] 유저 뱃지 상세 요청 - id: {}", id);
        UserBadge userBadge = userBadgeService.select(id);
        if (userBadge == null) {
            log.warn("[UserBadgeController] 유저 뱃지 없음 - id: {}", id);
            return "redirect:/user-badges?error=notfound";
        }
        log.info("[UserBadgeController] 유저 뱃지 상세: {}", userBadge);
        model.addAttribute("userBadge", userBadge);
        return "userbadge/detail"; // userbadge/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[UserBadgeController] 유저 뱃지 등록 폼 요청");
        model.addAttribute("userBadge", new UserBadge());
        return "userbadge/form"; // userbadge/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute UserBadge userBadge, Model model) throws Exception {
        log.info("[UserBadgeController] 유저 뱃지 등록 시도: {}", userBadge);
        boolean success = userBadgeService.insert(userBadge);
        if (success) {
            log.info("[UserBadgeController] 유저 뱃지 등록 성공: {}", userBadge);
            return "redirect:/user-badges";
        }
        log.warn("[UserBadgeController] 유저 뱃지 등록 실패: {}", userBadge);
        model.addAttribute("error", "등록 실패");
        return "userbadge/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[UserBadgeController] 유저 뱃지 수정 폼 요청 - id: {}", id);
        UserBadge userBadge = userBadgeService.select(id);
        if (userBadge == null) {
            log.warn("[UserBadgeController] 수정할 유저 뱃지 없음 - id: {}", id);
            return "redirect:/user-badges?error=notfound";
        }
        model.addAttribute("userBadge", userBadge);
        return "userbadge/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute UserBadge userBadge, Model model) throws Exception {
        log.info("[UserBadgeController] 유저 뱃지 수정 시도 - id: {}, userBadge: {}", id, userBadge);
        userBadge.setId(id);
        boolean success = userBadgeService.update(userBadge);
        if (success) {
            log.info("[UserBadgeController] 유저 뱃지 수정 성공 - id: {}", id);
            return "redirect:/user-badges/" + id;
        }
        log.warn("[UserBadgeController] 유저 뱃지 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "userbadge/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[UserBadgeController] 유저 뱃지 삭제 시도 - id: {}", id);
        userBadgeService.delete(id);
        log.info("[UserBadgeController] 유저 뱃지 삭제 완료 - id: {}", id);
        return "redirect:/user-badges";
    }

    // 관리자
    // 배지 자동 배분 기능
    @Autowired
    private BadgeGrantService badgeGrantService;

    @PostMapping("/check")
    public void checkAndGrantBadges(@RequestParam Long userId) throws Exception {
        badgeGrantService.checkAndGrantBadges(userId);
    }



}
