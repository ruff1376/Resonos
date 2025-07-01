package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosmus.resonos.service.TrackService;
import com.cosmus.resonos.domain.Track;

import groovy.util.logging.Slf4j;

@Slf4j
@Controller
@RequestMapping("/tracks")
public class TrackController {
    private final TrackService trackService;

    public TrackController(TrackService trackService) {
        this.trackService = trackService;
    }

    @GetMapping
    public List<Track> getAllTracks() {
        return trackService.getAllTracks();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Track> getTrack(@PathVariable String id) {
        Track track = trackService.getTrackById(id);
        if (track == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(track);
    }

    @PostMapping
    public ResponseEntity<String> createTrack(@RequestBody Track track) {
        boolean success = trackService.addTrack(track);
        if(success) {
            return ResponseEntity.ok("Track created");
        }
        return ResponseEntity.status(500).body("Failed to create track");
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateTrack(@PathVariable String id, @RequestBody Track track) {
        track.setId(id);
        boolean success = trackService.updateTrack(track);
        if(success) {
            return ResponseEntity.ok("Track updated");
        }
        return ResponseEntity.status(500).body("Failed to update track");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteTrack(@PathVariable String id) {
        boolean success = trackService.deleteTrack(id);
        if(success) {
            return ResponseEntity.ok("Track deleted");
        }
        return ResponseEntity.status(500).body("Failed to delete track");
    }
}
