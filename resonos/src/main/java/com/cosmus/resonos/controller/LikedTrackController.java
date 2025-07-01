package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.LikedTrack;
import com.cosmus.resonos.service.LikedTrackService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/liked-tracks")
public class LikedTrackController {

    @Autowired
    private LikedTrackService likedTrackService;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[LikedTrackController] 좋아요 트랙 목록 요청");
        List<LikedTrack> likedTracks = likedTrackService.list();
        log.info("[LikedTrackController] 좋아요 트랙 수: {}", likedTracks.size());
        model.addAttribute("likedTracks", likedTracks);
        return "likedtrack/list"; // likedtrack/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[LikedTrackController] 좋아요 트랙 상세 요청 - id: {}", id);
        LikedTrack likedTrack = likedTrackService.select(id);
        if (likedTrack == null) {
            log.warn("[LikedTrackController] 좋아요 트랙 없음 - id: {}", id);
            return "redirect:/liked-tracks?error=notfound";
        }
        log.info("[LikedTrackController] 좋아요 트랙 상세: {}", likedTrack);
        model.addAttribute("likedTrack", likedTrack);
        return "likedtrack/detail"; // likedtrack/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[LikedTrackController] 좋아요 트랙 등록 폼 요청");
        model.addAttribute("likedTrack", new LikedTrack());
        return "likedtrack/form"; // likedtrack/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute LikedTrack likedTrack, Model model) throws Exception {
        log.info("[LikedTrackController] 좋아요 트랙 등록 시도: {}", likedTrack);
        boolean success = likedTrackService.insert(likedTrack);
        if (success) {
            log.info("[LikedTrackController] 좋아요 트랙 등록 성공: {}", likedTrack);
            return "redirect:/liked-tracks";
        }
        log.warn("[LikedTrackController] 좋아요 트랙 등록 실패: {}", likedTrack);
        model.addAttribute("error", "등록 실패");
        return "likedtrack/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[LikedTrackController] 좋아요 트랙 수정 폼 요청 - id: {}", id);
        LikedTrack likedTrack = likedTrackService.select(id);
        if (likedTrack == null) {
            log.warn("[LikedTrackController] 수정할 좋아요 트랙 없음 - id: {}", id);
            return "redirect:/liked-tracks?error=notfound";
        }
        model.addAttribute("likedTrack", likedTrack);
        return "likedtrack/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute LikedTrack likedTrack, Model model) throws Exception {
        log.info("[LikedTrackController] 좋아요 트랙 수정 시도 - id: {}, likedTrack: {}", id, likedTrack);
        likedTrack.setId(id);
        boolean success = likedTrackService.update(likedTrack);
        if (success) {
            log.info("[LikedTrackController] 좋아요 트랙 수정 성공 - id: {}", id);
            return "redirect:/liked-tracks/" + id;
        }
        log.warn("[LikedTrackController] 좋아요 트랙 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "likedtrack/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[LikedTrackController] 좋아요 트랙 삭제 시도 - id: {}", id);
        likedTrackService.delete(id);
        log.info("[LikedTrackController] 좋아요 트랙 삭제 완료 - id: {}", id);
        return "redirect:/liked-tracks";
    }
}
