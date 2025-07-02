package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.PlaylistDetail;
import com.cosmus.resonos.service.PlaylistDetailService;

@RestController
@RequestMapping("/playlist-details")
public class PlaylistDetailController {

    private final PlaylistDetailService playlistDetailService;

    public PlaylistDetailController(PlaylistDetailService playlistDetailService) {
        this.playlistDetailService = playlistDetailService;
    }

    @GetMapping
    public ResponseEntity<List<PlaylistDetail>> getAllDetails() {
        try {
            List<PlaylistDetail> details = playlistDetailService.list();
            return ResponseEntity.ok(details);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<PlaylistDetail> getDetail(@PathVariable Long id) {
        try {
            PlaylistDetail detail = playlistDetailService.select(id);
            if (detail == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(detail);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @PostMapping
    public ResponseEntity<String> createDetail(@RequestBody PlaylistDetail detail) {
        try {
            boolean success = playlistDetailService.insert(detail);
            if (success) {
                return ResponseEntity.ok("Playlist detail created");
            }
            return ResponseEntity.status(500).body("Failed to create playlist detail");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to create playlist detail: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateDetail(@PathVariable Long id, @RequestBody PlaylistDetail detail) {
        try {
            detail.setId(id);
            boolean success = playlistDetailService.update(detail);
            if (success) {
                return ResponseEntity.ok("Playlist detail updated");
            }
            return ResponseEntity.status(500).body("Failed to update playlist detail");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to update playlist detail: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteDetail(@PathVariable Long id) {
        try {
            boolean success = playlistDetailService.delete(id);
            if (success) {
                return ResponseEntity.ok("Playlist detail deleted");
            }
            return ResponseEntity.status(500).body("Failed to delete playlist detail");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to delete playlist detail: " + e.getMessage());
        }
    }
}
