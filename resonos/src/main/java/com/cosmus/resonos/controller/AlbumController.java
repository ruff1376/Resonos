package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.service.AlbumService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/albums")
public class AlbumController {

    @Autowired
    private AlbumService albumService;

    // 앨범 목록 화면
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[AlbumController] 앨범 목록 요청");
        List<Album> albums = albumService.list();
        log.info("[AlbumController] 앨범 수: {}", albums.size());
        model.addAttribute("albums", albums);
        return "album/list"; // album/list.html
    }

    // 앨범 상세 화면
    @GetMapping("/{id}")
    public String detail(@PathVariable String id, Model model) throws Exception {
        log.info("[AlbumController] 앨범 상세 요청 - id: {}", id);
        Album album = albumService.select(Integer.valueOf(id));
        if (album == null) {
            log.warn("[AlbumController] 앨범 없음 - id: {}", id);
            return "redirect:/albums?error=notfound";
        }
        log.info("[AlbumController] 앨범 상세: {}", album);
        model.addAttribute("album", album);
        return "album/detail"; // album/detail.html
    }

    // 앨범 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[AlbumController] 앨범 등록 폼 요청");
        model.addAttribute("album", new Album());
        return "album/form"; // album/form.html
    }

    // 앨범 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute Album album, Model model) throws Exception {
        log.info("[AlbumController] 앨범 등록 시도: {}", album);
        boolean success = albumService.insert(album);
        if (success) {
            log.info("[AlbumController] 앨범 등록 성공: {}", album);
            return "redirect:/albums";
        }
        log.warn("[AlbumController] 앨범 등록 실패: {}", album);
        model.addAttribute("error", "등록 실패");
        return "album/form";
    }

    // 앨범 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable String id, Model model) throws Exception {
        log.info("[AlbumController] 앨범 수정 폼 요청 - id: {}", id);
        Album album = albumService.select(Integer.valueOf(id));
        if (album == null) {
            log.warn("[AlbumController] 수정할 앨범 없음 - id: {}", id);
            return "redirect:/albums?error=notfound";
        }
        model.addAttribute("album", album);
        return "album/form";
    }

    // 앨범 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable String id, @ModelAttribute Album album, Model model) throws Exception {
        log.info("[AlbumController] 앨범 수정 시도 - id: {}, album: {}", id, album);
        album.setId(id);
        boolean success = albumService.update(album);
        if (success) {
            log.info("[AlbumController] 앨범 수정 성공 - id: {}", id);
            return "redirect:/albums/" + id;
        }
        log.warn("[AlbumController] 앨범 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "album/form";
    }

    // 앨범 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable String id) throws Exception {
        log.info("[AlbumController] 앨범 삭제 시도 - id: {}", id);
        albumService.delete(id);
        log.info("[AlbumController] 앨범 삭제 완료 - id: {}", id);
        return "redirect:/albums";
    }
}
