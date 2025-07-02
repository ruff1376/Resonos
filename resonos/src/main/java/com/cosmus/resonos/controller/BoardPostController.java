package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.BoardPost;
import com.cosmus.resonos.service.BoardPostService;

@RestController
@RequestMapping("/board-posts")
public class BoardPostController {

    private final BoardPostService boardPostService;

    public BoardPostController(BoardPostService boardPostService) {
        this.boardPostService = boardPostService;
    }

    @GetMapping
    public ResponseEntity<List<BoardPost>> getAllPosts() {
        try {
            List<BoardPost> posts = boardPostService.list();
            return ResponseEntity.ok(posts);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<BoardPost> getPost(@PathVariable Long id) {
        try {
            BoardPost post = boardPostService.select(id);
            if (post == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(post);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @PostMapping
    public ResponseEntity<String> createPost(@RequestBody BoardPost post) {
        try {
            boolean success = boardPostService.insert(post);
            if (success) {
                return ResponseEntity.ok("Board post created");
            }
            return ResponseEntity.status(500).body("Failed to create board post");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to create board post: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updatePost(@PathVariable Long id, @RequestBody BoardPost post) {
        try {
            post.setId(id);
            boolean success = boardPostService.update(post);
            if (success) {
                return ResponseEntity.ok("Board post updated");
            }
            return ResponseEntity.status(500).body("Failed to update board post");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to update board post: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deletePost(@PathVariable Long id) {
        try {
            boolean success = boardPostService.delete(id);
            if (success) {
                return ResponseEntity.ok("Board post deleted");
            }
            return ResponseEntity.status(500).body("Failed to delete board post");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to delete board post: " + e.getMessage());
        }
    }

    // 커뮤니티별 게시글 목록 조회
    @GetMapping("/community/{communityId}")
    public ResponseEntity<List<BoardPost>> getPostsByCommunity(@PathVariable Long communityId) {
        try {
            List<BoardPost> posts = boardPostService.findByCommunity(communityId);
            return ResponseEntity.ok(posts);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }
}
