package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

import groovy.util.logging.Slf4j;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.service.ArtistService;


@Slf4j
@Controller
@RequestMapping("/artists")
public class ArtistController {

    @GetMapping("/artist")
    public String artist() {
        return "/review/artist";
    }
    private final ArtistService artistService;

    public ArtistController(ArtistService artistService) {
        this.artistService = artistService;
    }

    @GetMapping
    public List<Artist> getAllArtists() {
        return artistService.getAllArtists();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Artist> getArtist(@PathVariable String id) {
        Artist artist = artistService.getArtistById(id);
        if (artist == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(artist);
    }

    @PostMapping
    public ResponseEntity<String> createArtist(@RequestBody Artist artist) {
        boolean success = artistService.addArtist(artist);
        if(success) {
            return ResponseEntity.ok("Artist created");
        }
        return ResponseEntity.status(500).body("Failed to create artist");
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateArtist(@PathVariable String id, @RequestBody Artist artist) {
        artist.setId(id);
        boolean success = artistService.updateArtist(artist);
        if(success) {
            return ResponseEntity.ok("Artist updated");
        }
        return ResponseEntity.status(500).body("Failed to update artist");
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteArtist(@PathVariable String id) {
        boolean success = artistService.deleteArtist(id);
        if(success) {
            return ResponseEntity.ok("Artist deleted");
        }
        return ResponseEntity.status(500).body("Failed to delete artist");
    }

}
