package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.service.AlbumService;

import groovy.util.logging.Slf4j;

@Slf4j
@Controller
@RequestMapping("/albums")
public class AlbumController {
    private final AlbumService albumService;

    public AlbumController(AlbumService albumService) {
        this.albumService = albumService;
    }

    // 전체 앨범 목록 조회
    @GetMapping
    public ResponseEntity<List<Album>> getAllAlbums() {
        try {
            List<Album> albums = albumService.list();
            return ResponseEntity.ok(albums);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    // 단일 앨범 조회 (id를 Integer로 변환해서 전달)
    @GetMapping("/{id}")
    public ResponseEntity<Album> getAlbum(@PathVariable String id) {
        try {
            // AlbumService.select(Integer no) 이므로 id를 Integer로 변환
            Album album = albumService.select(Integer.valueOf(id));
            if (album == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(album);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    // 앨범 생성
    @PostMapping
    public ResponseEntity<String> createAlbum(@RequestBody Album album) {
        try {
            boolean success = albumService.insert(album);
            if (success) {
                return ResponseEntity.ok("Album created");
            }
            return ResponseEntity.status(500).body("Failed to create album");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to create album: " + e.getMessage());
        }
    }

    // 앨범 수정
    @PutMapping("/{id}")
    public ResponseEntity<String> updateAlbum(@PathVariable String id, @RequestBody Album album) {
        try {
            album.setId(id); // id 세팅
            boolean success = albumService.update(album);
            if (success) {
                return ResponseEntity.ok("Album updated");
            }
            return ResponseEntity.status(500).body("Failed to update album");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to update album: " + e.getMessage());
        }
    }

    // 앨범 삭제
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteAlbum(@PathVariable String id) {
        try {
            boolean success = albumService.delete(id);
            if (success) {
                return ResponseEntity.ok("Album deleted");
            }
            return ResponseEntity.status(500).body("Failed to delete album");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to delete album: " + e.getMessage());
        }
    }
}
