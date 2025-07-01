package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.LikedPlaylist;
import com.cosmus.resonos.service.LikedPlaylistService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/liked-playlists")
public class LikedPlaylistController {

    @Autowired
    private LikedPlaylistService likedPlaylistService;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[LikedPlaylistController] 좋아요 플레이리스트 목록 요청");
        List<LikedPlaylist> playlists = likedPlaylistService.list();
        log.info("[LikedPlaylistController] 좋아요 수: {}", playlists.size());
        model.addAttribute("playlists", playlists);
        return "likedplaylist/list"; // likedplaylist/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[LikedPlaylistController] 좋아요 플레이리스트 상세 요청 - id: {}", id);
        LikedPlaylist playlist = likedPlaylistService.select(id);
        if (playlist == null) {
            log.warn("[LikedPlaylistController] 없음 - id: {}", id);
            return "redirect:/liked-playlists?error=notfound";
        }
        log.info("[LikedPlaylistController] 상세: {}", playlist);
        model.addAttribute("playlist", playlist);
        return "likedplaylist/detail"; // likedplaylist/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[LikedPlaylistController] 등록 폼 요청");
        model.addAttribute("playlist", new LikedPlaylist());
        return "likedplaylist/form"; // likedplaylist/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute LikedPlaylist playlist, Model model) throws Exception {
        log.info("[LikedPlaylistController] 등록 시도: {}", playlist);
        boolean success = likedPlaylistService.insert(playlist);
        if (success) {
            log.info("[LikedPlaylistController] 등록 성공: {}", playlist);
            return "redirect:/liked-playlists";
        }
        log.warn("[LikedPlaylistController] 등록 실패: {}", playlist);
        model.addAttribute("error", "등록 실패");
        return "likedplaylist/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[LikedPlaylistController] 수정 폼 요청 - id: {}", id);
        LikedPlaylist playlist = likedPlaylistService.select(id);
        if (playlist == null) {
            log.warn("[LikedPlaylistController] 수정할 항목 없음 - id: {}", id);
            return "redirect:/liked-playlists?error=notfound";
        }
        model.addAttribute("playlist", playlist);
        return "likedplaylist/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute LikedPlaylist playlist, Model model) throws Exception {
        log.info("[LikedPlaylistController] 수정 시도 - id: {}, playlist: {}", id, playlist);
        playlist.setId(id);
        boolean success = likedPlaylistService.update(playlist);
        if (success) {
            log.info("[LikedPlaylistController] 수정 성공 - id: {}", id);
            return "redirect:/liked-playlists/" + id;
        }
        log.warn("[LikedPlaylistController] 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "likedplaylist/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[LikedPlaylistController] 삭제 시도 - id: {}", id);
        likedPlaylistService.delete(id);
        log.info("[LikedPlaylistController] 삭제 완료 - id: {}", id);
        return "redirect:/liked-playlists";
    }
}
