package com.cosmus.resonos.controller;

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
import com.cosmus.resonos.domain.Album.Album;
import com.cosmus.resonos.domain.Album.LikedAlbum;
import com.cosmus.resonos.domain.Track.Track;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.LikedAlbumService;
import com.cosmus.resonos.service.TrackService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/liked-albums")
public class LikedAlbumController {

    @Autowired
    private LikedAlbumService likedAlbumService;
    @Autowired
    private AlbumService albumService;
    @Autowired
    private TrackService trackService;

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[LikedAlbumController] 좋아요 앨범 상세 요청 - id: {}", id);
        LikedAlbum likedAlbum = likedAlbumService.select(id);
        if (likedAlbum == null) {
            log.warn("[LikedAlbumController] 좋아요 앨범 없음 - id: {}", id);
            return "redirect:/liked-albums?error=notfound";
        }
        log.info("[LikedAlbumController] 좋아요 앨범 상세: {}", likedAlbum);
        model.addAttribute("likedAlbum", likedAlbum);
        return "likedalbum/detail"; // likedalbum/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[LikedAlbumController] 좋아요 앨범 등록 폼 요청");
        model.addAttribute("likedAlbum", new LikedAlbum());
        return "likedalbum/form"; // likedalbum/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute LikedAlbum likedAlbum, Model model) throws Exception {
        log.info("[LikedAlbumController] 좋아요 앨범 등록 시도: {}", likedAlbum);
        boolean success = likedAlbumService.insert(likedAlbum);
        if (success) {
            log.info("[LikedAlbumController] 좋아요 앨범 등록 성공: {}", likedAlbum);
            return "redirect:/liked-albums";
        }
        log.warn("[LikedAlbumController] 좋아요 앨범 등록 실패: {}", likedAlbum);
        model.addAttribute("error", "등록 실패");
        return "likedalbum/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[LikedAlbumController] 좋아요 앨범 수정 폼 요청 - id: {}", id);
        LikedAlbum likedAlbum = likedAlbumService.select(id);
        if (likedAlbum == null) {
            log.warn("[LikedAlbumController] 수정할 좋아요 앨범 없음 - id: {}", id);
            return "redirect:/liked-albums?error=notfound";
        }
        model.addAttribute("likedAlbum", likedAlbum);
        return "likedalbum/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute LikedAlbum likedAlbum, Model model) throws Exception {
        log.info("[LikedAlbumController] 좋아요 앨범 수정 시도 - id: {}, likedAlbum: {}", id, likedAlbum);
        likedAlbum.setId(id);
        boolean success = likedAlbumService.update(likedAlbum);
        if (success) {
            log.info("[LikedAlbumController] 좋아요 앨범 수정 성공 - id: {}", id);
            return "redirect:/liked-albums/" + id;
        }
        log.warn("[LikedAlbumController] 좋아요 앨범 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "likedalbum/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[LikedAlbumController] 좋아요 앨범 삭제 시도 - id: {}", id);
        likedAlbumService.deleteById(id);
        log.info("[LikedAlbumController] 좋아요 앨범 삭제 완료 - id: {}", id);
        return "redirect:/liked-albums";
    }
}
