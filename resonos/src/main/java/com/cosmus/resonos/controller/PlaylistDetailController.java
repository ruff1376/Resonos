package com.cosmus.resonos.controller;

import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.exceptions.PersistenceException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cosmus.resonos.domain.PlaylistDTO;
import com.cosmus.resonos.domain.PlaylistDetail;
import com.cosmus.resonos.service.PlaylistDetailService;
import com.cosmus.resonos.service.PlaylistService;

@RestController
@RequestMapping("/playlist-details")
public class PlaylistDetailController {

    @Autowired
    private PlaylistDetailService playlistDetailService;

    @Autowired
    private PlaylistService playlistService;

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
