package com.cosmus.resonos.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosmus.resonos.domain.ArtistFollow;
import com.cosmus.resonos.service.ArtistFollowService;
import com.cosmus.resonos.service.ArtistService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/artist-follows")
public class ArtistFollowController {

    @Autowired
    private ArtistFollowService artistFollowService;
    @Autowired
    private ArtistService artistService;

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[ArtistFollowController] 아티스트 팔로우 등록 폼 요청");
        model.addAttribute("follow", new ArtistFollow());
        return "artistfollow/form"; // artistfollow/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute ArtistFollow follow, Model model) throws Exception {
        log.info("[ArtistFollowController] 아티스트 팔로우 등록 시도: {}", follow);
        boolean success = artistFollowService.insert(follow);
        if (success) {
            log.info("[ArtistFollowController] 아티스트 팔로우 등록 성공: {}", follow);
            return "redirect:/artist-follows";
        }
        log.warn("[ArtistFollowController] 아티스트 팔로우 등록 실패: {}", follow);
        model.addAttribute("error", "등록 실패");
        return "artistfollow/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable String id, Model model) throws Exception {
        log.info("[ArtistFollowController] 아티스트 팔로우 수정 폼 요청 - id: {}", id);
        ArtistFollow follow = artistFollowService.select(id);
        if (follow == null) {
            log.warn("[ArtistFollowController] 수정할 팔로우 없음 - id: {}", id);
            return "redirect:/artist-follows?error=notfound";
        }
        model.addAttribute("follow", follow);
        return "artistfollow/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute ArtistFollow follow, Model model) throws Exception {
        log.info("[ArtistFollowController] 아티스트 팔로우 수정 시도 - id: {}, follow: {}", id, follow);
        follow.setId(id);
        boolean success = artistFollowService.update(follow);
        if (success) {
            log.info("[ArtistFollowController] 아티스트 팔로우 수정 성공 - id: {}", id);
            return "redirect:/artist-follows/" + id;
        }
        log.warn("[ArtistFollowController] 아티스트 팔로우 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "artistfollow/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[ArtistFollowController] 아티스트 팔로우 삭제 시도 - id: {}", id);
        artistFollowService.delete(id);
        log.info("[ArtistFollowController] 아티스트 팔로우 삭제 완료 - id: {}", id);
        return "redirect:/artist-follows";
    }
}
