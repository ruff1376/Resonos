package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Vote.Tag;
import com.cosmus.resonos.service.TagService;

@RestController
@RequestMapping("/tags")
public class TagController {

    private final TagService tagService;

    public TagController(TagService tagService) {
        this.tagService = tagService;
    }

    @GetMapping
    public ResponseEntity<List<Tag>> getAllTags() {
        try {
            List<Tag> tags = tagService.list();
            return ResponseEntity.ok(tags);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Tag> getTag(@PathVariable Long id) {
        try {
            Tag tag = tagService.select(id);
            if (tag == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(tag);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @PostMapping
    public ResponseEntity<String> createTag(@RequestBody Tag tag) {
        try {
            boolean success = tagService.insert(tag);
            if (success) {
                return ResponseEntity.ok("Tag created");
            }
            return ResponseEntity.status(500).body("Failed to create tag");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to create tag: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateTag(@PathVariable Long id, @RequestBody Tag tag) {
        try {
            tag.setId(id);
            boolean success = tagService.update(tag);
            if (success) {
                return ResponseEntity.ok("Tag updated");
            }
            return ResponseEntity.status(500).body("Failed to update tag");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to update tag: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteTag(@PathVariable Long id) {
        try {
            boolean success = tagService.delete(id);
            if (success) {
                return ResponseEntity.ok("Tag deleted");
            }
            return ResponseEntity.status(500).body("Failed to delete tag");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to delete tag: " + e.getMessage());
        }
    }
}
