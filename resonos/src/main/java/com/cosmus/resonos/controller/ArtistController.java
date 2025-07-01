package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.service.ArtistService;

import groovy.util.logging.Slf4j;

@Slf4j
@ControllerAdvice
@RequestMapping("/artists")
public class ArtistController {

    private final ArtistService artistService;

    public ArtistController(ArtistService artistService) {
        this.artistService = artistService;
    }

    // 아티스트 목록 조회
    @GetMapping
    public ResponseEntity<List<Artist>> getAllArtists() {
        try {
            List<Artist> artists = artistService.list();
            return ResponseEntity.ok(artists);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    // 아티스트 단건 조회 (id를 Integer로 변환해서 전달)
    @GetMapping("/{id}")
    public ResponseEntity<Artist> getArtist(@PathVariable String id) {
        try {
            Artist artist = artistService.select(Integer.valueOf(id));
            if (artist == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(artist);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    // 아티스트 등록
    @PostMapping
    public ResponseEntity<String> createArtist(@RequestBody Artist artist) {
        try {
            boolean success = artistService.insert(artist);
            if (success) {
                return ResponseEntity.ok("Artist created");
            }
            return ResponseEntity.status(500).body("Failed to create artist");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to create artist: " + e.getMessage());
        }
    }

    // 아티스트 수정
    @PutMapping("/{id}")
    public ResponseEntity<String> updateArtist(@PathVariable String id, @RequestBody Artist artist) {
        try {
            artist.setId(id);
            boolean success = artistService.update(artist);
            if (success) {
                return ResponseEntity.ok("Artist updated");
            }
            return ResponseEntity.status(500).body("Failed to update artist");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to update artist: " + e.getMessage());
        }
    }

    // 아티스트 삭제
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteArtist(@PathVariable String id) {
        try {
            boolean success = artistService.delete(id);
            if (success) {
                return ResponseEntity.ok("Artist deleted");
            }
            return ResponseEntity.status(500).body("Failed to delete artist");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to delete artist: " + e.getMessage());
        }
    }
}
