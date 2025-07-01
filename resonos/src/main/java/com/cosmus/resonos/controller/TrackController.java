package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.service.TrackService;

import groovy.util.logging.Slf4j;

import com.cosmus.resonos.domain.Track;

@Slf4j
@Controller
@RequestMapping("/tracks")
public class TrackController {
    private final TrackService trackService;

    public TrackController(TrackService trackService) {
        this.trackService = trackService;
    }

    // 트랙 목록 조회
    @GetMapping
    public ResponseEntity<List<Track>> getAllTracks() {
        try {
            List<Track> tracks = trackService.list();
            return ResponseEntity.ok(tracks);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    // 트랙 단건 조회 (id를 Integer로 변환해서 전달)
    @GetMapping("/{id}")
    public ResponseEntity<Track> getTrack(@PathVariable String id) {
        try {
            Track track = trackService.select(Integer.valueOf(id));
            if (track == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(track);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    // 트랙 등록
    @PostMapping
    public ResponseEntity<String> createTrack(@RequestBody Track track) {
        try {
            boolean success = trackService.insert(track);
            if (success) {
                return ResponseEntity.ok("Track created");
            }
            return ResponseEntity.status(500).body("Failed to create track");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to create track: " + e.getMessage());
        }
    }

    // 트랙 수정
    @PutMapping("/{id}")
    public ResponseEntity<String> updateTrack(@PathVariable String id, @RequestBody Track track) {
        try {
            track.setId(id);
            boolean success = trackService.update(track);
            if (success) {
                return ResponseEntity.ok("Track updated");
            }
            return ResponseEntity.status(500).body("Failed to update track");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to update track: " + e.getMessage());
        }
    }

    // 트랙 삭제
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteTrack(@PathVariable String id) {
        try {
            boolean success = trackService.delete(id);
            if (success) {
                return ResponseEntity.ok("Track deleted");
            }
            return ResponseEntity.status(500).body("Failed to delete track");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to delete track: " + e.getMessage());
        }
    }
}
