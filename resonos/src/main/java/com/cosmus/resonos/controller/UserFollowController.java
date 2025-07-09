package com.cosmus.resonos.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.UserFollow;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.service.BadgeGrantService;
import com.cosmus.resonos.service.UserFollowService;
import com.cosmus.resonos.service.UserService;
import com.cosmus.resonos.util.CheckAuthentication;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user-follows")
public class UserFollowController {

    @Autowired
    private UserFollowService userFollowService;
    @Autowired
    private UserService userService;
    @Autowired
    private BadgeGrantService badgeGrantService;

    /**
     * 유저 팔로우 페이지 요청
     * @param model
     * @param request
     * @return
     * @throws Exception
     */
    @GetMapping({"", "/{id}"})
    public String followUsers(
        Model model,
        @AuthenticationPrincipal CustomUser loginUser,
        @PathVariable(value = "id", required = false) Long id
    ) throws Exception {
        if(id == null && loginUser == null) return "redirect:/login";

        // PathVariable 검사
        Long targetId = (id != null) ? id : loginUser.getUser().getId();
        // 자기 자신인지
        boolean isOwner = loginUser != null && loginUser.getId().equals(targetId);
        // 팔로우, 팔로워 정보
        List<Users> myFollower = userFollowService.myFollower(targetId);
        List<Users> myFollow = userFollowService.myFollow(targetId);

        model.addAttribute("myFollower", myFollower);
        model.addAttribute("myFollow", myFollow);
        model.addAttribute("lastPath", "user-follows");
        model.addAttribute("isOwner", isOwner);
        return "user/follow_user";
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
    public String createPost(@ModelAttribute UserFollow follow, Model model,
                            @AuthenticationPrincipal CustomUser customUser) throws Exception {
        log.info("[UserFollowController] 팔로우 등록 시도: {}", follow);
        boolean success = userFollowService.insert(follow);

        // 팔로우 등록 성공 시 배지 자동 지급 트리거 호출
        if (success && customUser != null) {
            badgeGrantService.checkAndGrantBadges(customUser.getUser().getId());
        }

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
