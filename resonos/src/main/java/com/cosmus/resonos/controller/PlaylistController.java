package com.cosmus.resonos.controller;

import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.Playlist;
import com.cosmus.resonos.domain.PlaylistDTO;
import com.cosmus.resonos.service.PlaylistService;

import lombok.extern.slf4j.Slf4j;


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
     * @throws Exception
     */
    @GetMapping("")
    public String playlist(@AuthenticationPrincipal CustomUser loginUser, Model model) throws Exception {

        List<Playlist> myPlaylists = playlistService.usersPlaylist(loginUser.getUser().getId());
        List<Playlist> likedPlaylists = playlistService.likedPlaylist(loginUser.getUser().getId());

        model.addAttribute("loginUser", loginUser.getUser());
        model.addAttribute("myPlaylists", myPlaylists);
        model.addAttribute("likedPlaylists", likedPlaylists);
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
     * @throws Exception
     */
    @GetMapping("/{id}")
    public String playlistDetail(Model model, @PathVariable("id") long id, @RequestParam(value = "success", required = false) String success) throws Exception {
        PlaylistDTO playlist = playlistService.trackOfPlaylist(id);

        if(playlist == null) {
            model.addAttribute("playlist", playlistService.select(id));
        } else {
            model.addAttribute("playlist", playlist);
        }
        model.addAttribute("success", success);
        model.addAttribute("lastPath", "playlist");
        model.addAttribute("playlistObj", new Playlist());
        return "user/playlist_detail";
    }

    /**
     * 트랙 순서 바꾸기 요청
     * @param playlistId
     * @param orderList
     * @return
     * @throws Exception
     */
    @PutMapping("/{playlistId}/tracks/order")
    public ResponseEntity<?> postMethodName(@PathVariable("playlistId") String playlistId, @RequestBody List<Map<String, Object>> orderList) throws Exception {
        boolean result = playlistService.updateTrackOrder(playlistId, orderList);
        if(result) return new ResponseEntity<>("정렬 완료.", HttpStatus.OK);

        return new ResponseEntity<>("정렬 실패.", HttpStatus.BAD_REQUEST);
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

    @PostMapping("/{id}")
    public String updatePlaylist(@PathVariable Long id, @ModelAttribute Playlist playlist, @AuthenticationPrincipal CustomUser loginUser) throws Exception {
        Playlist currentPlaylist = playlistService.select(id);
        if(!currentPlaylist.getUserId().equals(loginUser.getUser().getId()))
            return "redirect:/playlists/" + id + "?owner=false";
        else {
            playlist.setId(id);
            playlist.setUserId(loginUser.getUser().getId());
            boolean success = playlistService.update(playlist);
            if (success)  {
                log.info("updatePlaylist : 플레이리스트 업데이트 성공");
                return "redirect:/playlists/" + id + "?success=true";
            }
        }
        return "redirect:/playlists/" + id + "?success=false";
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
