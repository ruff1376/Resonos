package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.TrackService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/tracks")
public class TrackController {


    @Autowired
    private TrackService trackService;
    @Autowired
    private AlbumService albumService;
    // @GetMapping({"/",""})
    // public String track() {
    //     return "review/track";
    // }
    
    // 트랙 화면
    @GetMapping
    public String trackInfo(@RequestParam("id") String id, Model model) throws Exception {
        Track track = trackService.selectById(id);
        Album album = albumService.findAlbumByTrackId(id);
        List<Track> top5List = trackService.findTop5TracksInSameAlbum(id);
        String artistName = trackService.findArtistNameByTrackId(id);
    if (track == null) {
        return "redirect:/artists?error=notfound";
    }
    model.addAttribute("track", track);
    model.addAttribute("album", album);
    model.addAttribute("top5List", top5List);
    model.addAttribute("artistName", artistName);
    return "review/track";
    }

    // @Autowired
    // private TrackService trackService;

    // // 트랙 목록 화면
    // @GetMapping
    // public String list(Model model) throws Exception {
    //     log.info("[TrackController] 트랙 목록 요청");
    //     List<Track> tracks = trackService.list();
    //     log.info("[TrackController] 트랙 수: {}", tracks.size());
    //     model.addAttribute("tracks", tracks);
    //     return "track/list"; // track/list.html
    // }

    // // 트랙 상세 화면
    // @GetMapping("/{id}")
    // public String detail(@PathVariable String id, Model model) throws Exception {
    //     log.info("[TrackController] 트랙 상세 요청 - id: {}", id);
    //     Track track = trackService.select(Integer.valueOf(id));
    //     if (track == null) {
    //         log.warn("[TrackController] 트랙 없음 - id: {}", id);
    //         return "redirect:/tracks?error=notfound";
    //     }
    //     log.info("[TrackController] 트랙 상세: {}", track);
    //     model.addAttribute("track", track);
    //     return "track/detail"; // track/detail.html
    // }

    // // 트랙 등록 폼
    // @GetMapping("/new")
    // public String create(Model model) {
    //     log.info("[TrackController] 트랙 등록 폼 요청");
    //     model.addAttribute("track", new Track());
    //     return "track/form"; // track/form.html
    // }

    // // 트랙 등록 처리
    // @PostMapping
    // public String createPost(@ModelAttribute Track track, Model model) throws Exception {
    //     log.info("[TrackController] 트랙 등록 시도: {}", track);
    //     boolean success = trackService.insert(track);
    //     if (success) {
    //         log.info("[TrackController] 트랙 등록 성공: {}", track);
    //         return "redirect:/tracks";
    //     }
    //     log.warn("[TrackController] 트랙 등록 실패: {}", track);
    //     model.addAttribute("error", "등록 실패");
    //     return "track/form";
    // }

    // // 트랙 수정 폼
    // @GetMapping("/{id}/edit")
    // public String update(@PathVariable String id, Model model) throws Exception {
    //     log.info("[TrackController] 트랙 수정 폼 요청 - id: {}", id);
    //     Track track = trackService.select(Integer.valueOf(id));
    //     if (track == null) {
    //         log.warn("[TrackController] 수정할 트랙 없음 - id: {}", id);
    //         return "redirect:/tracks?error=notfound";
    //     }
    //     model.addAttribute("track", track);
    //     return "track/form";
    // }

    // // 트랙 수정 처리
    // @PostMapping("/{id}/edit")
    // public String updatePost(@PathVariable String id, @ModelAttribute Track track, Model model) throws Exception {
    //     log.info("[TrackController] 트랙 수정 시도 - id: {}, track: {}", id, track);
    //     track.setId(id);
    //     boolean success = trackService.update(track);
    //     if (success) {
    //         log.info("[TrackController] 트랙 수정 성공 - id: {}", id);
    //         return "redirect:/tracks/" + id;
    //     }
    //     log.warn("[TrackController] 트랙 수정 실패 - id: {}", id);
    //     model.addAttribute("error", "수정 실패");
    //     return "track/form";
    // }

    // // 트랙 삭제 처리
    // @PostMapping("/{id}/delete")
    // public String delete(@PathVariable String id) throws Exception {
    //     log.info("[TrackController] 트랙 삭제 시도 - id: {}", id);
    //     trackService.delete(id);
    //     log.info("[TrackController] 트랙 삭제 완료 - id: {}", id);
    //     return "redirect:/tracks";
    // }
}
