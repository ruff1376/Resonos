package com.cosmus.resonos.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.UserFollow;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.service.BadgeGrantService;
import com.cosmus.resonos.service.UserFollowService;
import com.cosmus.resonos.service.UserService;

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

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[UserFollowController] 팔로우 등록 폼 요청");
        model.addAttribute("follow", new UserFollow());
        return "userfollow/form"; // userfollow/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(
        @ModelAttribute UserFollow follow, Model model,
        @AuthenticationPrincipal CustomUser customUser
    ) throws Exception {
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
    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(
        @AuthenticationPrincipal CustomUser loginUser,
        @PathVariable("id") Long id
    ) throws Exception {
        boolean result = userFollowService.delete(loginUser.getId(), id);
        if(result)
            return new ResponseEntity<>("팔로우 취소하였습니다.", HttpStatus.OK);
        return new ResponseEntity<>("언팔로우가 실패하였습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
    }

    /**
     * 유저 팔로우
     * @param loginUser
     * @param id
     * @return
     * @throws Exception
     */
    @PostMapping(value = "{id}")
    public ResponseEntity<?> postMethodName(
        @AuthenticationPrincipal CustomUser loginUser,
        @PathVariable("id") Long id
    ) throws Exception {
        if(loginUser == null) {
            return new ResponseEntity<>("로그인이 필요한 서비스입니다.", HttpStatus.BAD_REQUEST);
        }

        UserFollow uf = new UserFollow();
        uf.setFollowerId(loginUser.getId());
        uf.setFollowingId(id);
        boolean result = userFollowService.insert(uf);
        if(result)
            return new ResponseEntity<>("팔로우 하였습니다.", HttpStatus.OK);

        return new ResponseEntity<>("팔로우가 실패하였습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
    }

    /**
     * 팔로우 유저 비동기 검색
     * @param data
     * @return
     * @throws Exception
     */
    @PostMapping("/search")
    public ResponseEntity<?> searchMyAlbums(
        @RequestBody Map<String, Object> data
    ) throws Exception {
        Long userId = Long.valueOf(data.get("userId").toString());
        String keyword = data.get("keyword").toString();
        String choice = data.get("choice").toString();
        List<Users> userList = null;

        if(choice.equals("follow"))
            userList = userFollowService.myFollow(userId, keyword);
        else
            userList = userFollowService.myFollower(userId, keyword);

        if(userList != null)
            return new ResponseEntity<>(userList, HttpStatus.OK);

        return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
    }

}
