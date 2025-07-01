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

    @GetMapping
    public List<Album> getAllAlbums() {
        return albumService.getAllAlbums();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Album> getAlbum(@PathVariable String id) {
        Album album = albumService.getAlbumById(id);
        if (album == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(album);
    }

    @PostMapping
    public ResponseEntity<String> createAlbum(@RequestBody Album album) {
        boolean success = albumService.addAlbum(album);
        if(success) {
            return ResponseEntity.ok("Album created");
        }
        return ResponseEntity.status(500).body("Failed to create album");
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateAlbum(@PathVariable String id, @RequestBody Album album) {
        album.setId(id);
        boolean success = albumService.updateAlbum(album);
        if(success) {
            return ResponseEntity.ok("Album updated");
        }
        return ResponseEntity.status(500).body("Failed to update album");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteAlbum(@PathVariable String id) {
        boolean success = albumService.deleteAlbum(id);
        if(success) {
            return ResponseEntity.ok("Album deleted");
        }
        return ResponseEntity.status(500).body("Failed to delete album");
    }
}
