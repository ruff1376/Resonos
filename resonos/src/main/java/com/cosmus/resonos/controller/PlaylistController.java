package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Playlist;
import com.cosmus.resonos.service.PlaylistService;

@RestController
@RequestMapping("/playlists")
public class PlaylistController {

    private final PlaylistService playlistService;

    public PlaylistController(PlaylistService playlistService) {
        this.playlistService = playlistService;
    }

    @GetMapping
    public ResponseEntity<List<Playlist>> getAllPlaylists() {
        try {
            List<Playlist> playlists = playlistService.list();
            return ResponseEntity.ok(playlists);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Playlist> getPlaylist(@PathVariable Long id) {
        try {
            Playlist playlist = playlistService.select(id);
            if (playlist == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(playlist);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
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
