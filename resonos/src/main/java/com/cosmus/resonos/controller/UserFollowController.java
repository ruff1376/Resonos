package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.UserFollow;
import com.cosmus.resonos.service.UserFollowService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user-follows")
public class UserFollowController {

    @Autowired
    private UserFollowService userFollowService;

    /**
     * 유저 팔로우 페이지 요청
     * @param model
     * @param request
     * @return
     */
    @GetMapping("/{id}")
    public String followUsers(Model model, @PathVariable("id") long id) {

        model.addAttribute("lastPath", "user-follows");

        return "user/follow_user";
    }




    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[UserFollowController] 팔로우 목록 요청");
        List<UserFollow> follows = userFollowService.list();
        log.info("[UserFollowController] 팔로우 수: {}", follows.size());
        model.addAttribute("follows", follows);
        return "userfollow/list"; // userfollow/list.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[UserFollowController] 팔로우 등록 폼 요청");
        model.addAttribute("follow", new UserFollow());
        return "userfollow/form"; // userfollow/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute UserFollow follow, Model model) throws Exception {
        log.info("[UserFollowController] 팔로우 등록 시도: {}", follow);
        boolean success = userFollowService.insert(follow);
        if (success) {
            log.info("[UserFollowController] 팔로우 등록 성공: {}", follow);
            return "redirect:/user-follows";
        }
        log.warn("[UserFollowController] 팔로우 등록 실패: {}", follow);
        model.addAttribute("error", "등록 실패");
        return "userfollow/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[UserFollowController] 팔로우 수정 폼 요청 - id: {}", id);
        UserFollow follow = userFollowService.select(id);
        if (follow == null) {
            log.warn("[UserFollowController] 수정할 팔로우 없음 - id: {}", id);
            return "redirect:/user-follows?error=notfound";
        }
        model.addAttribute("follow", follow);
        return "userfollow/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute UserFollow follow, Model model) throws Exception {
        log.info("[UserFollowController] 팔로우 수정 시도 - id: {}, follow: {}", id, follow);
        follow.setId(id);
        boolean success = userFollowService.update(follow);
        if (success) {
            log.info("[UserFollowController] 팔로우 수정 성공 - id: {}", id);
            return "redirect:/user-follows/" + id;
        }
        log.warn("[UserFollowController] 팔로우 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "userfollow/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[UserFollowController] 팔로우 삭제 시도 - id: {}", id);
        userFollowService.delete(id);
        log.info("[UserFollowController] 팔로우 삭제 완료 - id: {}", id);
        return "redirect:/user-follows";
    }
}
