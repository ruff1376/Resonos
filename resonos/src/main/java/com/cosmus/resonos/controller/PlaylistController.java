package com.cosmus.resonos.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosmus.resonos.domain.Playlist;
import com.cosmus.resonos.service.PlaylistService;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestParam;


@Slf4j
@RequestMapping("/playlists")
@Controller
public class PlaylistController {

    private final PlaylistService playlistService;


    public PlaylistController(PlaylistService playlistService) {
        this.playlistService = playlistService;
    }

    /**
     * 플레이리스트 페이지 요청
     * @param model
     * @return
     */
    @GetMapping("")
    // TODO: @AuthenticationPrincipal 로 출력할 리스트 나누기
    public String playlist(Model model) {
        model.addAttribute("lastPath", "playlist");
        return "user/playlist";
    }

    /**
     * 플레이리스트 추가 페이지 요청
     * @param model
     * @return
     */
    @GetMapping("/create")
    public String playlistCreate(Model model) {

        model.addAttribute("playlistObj", Playlist.builder().isPublic(true).build());
        model.addAttribute("lastPath", "playlist");

        return "user/create_playlist";
    }

    /**
     * 플레이리스트 상세 페이지 요청
     * @param model
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    public String playlistDetail(Model model, @PathVariable("id") long id) {
        // TODO: 플레이리스트 DB 조회

        model.addAttribute("lastPath", "playlist");
        model.addAttribute("playlistObj", new Playlist());
        return "user/playlist_detail";
    }


    @PostMapping
    public ResponseEntity<String> createPlaylist(@RequestBody Playlist playlist) {
        try {
            boolean success = playlistService.insert(playlist);
            if (success) {
                return ResponseEntity.ok("Playlist created");
            }
            return ResponseEntity.status(500).body("Failed to create playlist");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to create playlist: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updatePlaylist(@PathVariable Long id, @RequestBody Playlist playlist) {
        try {
            playlist.setId(id);
            boolean success = playlistService.update(playlist);
            if (success) {
                return ResponseEntity.ok("Playlist updated");
            }
            return ResponseEntity.status(500).body("Failed to update playlist");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to update playlist: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deletePlaylist(@PathVariable Long id) {
        try {
            boolean success = playlistService.delete(id);
            if (success) {
                return ResponseEntity.ok("Playlist deleted");
            }
            return ResponseEntity.status(500).body("Failed to delete playlist");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to delete playlist: " + e.getMessage());
        }
    }
}
