package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Comment;
import com.cosmus.resonos.service.CommentService;

@RestController
@RequestMapping("/comments")
public class CommentController {

    private final CommentService commentService;

    public CommentController(CommentService commentService) {
        this.commentService = commentService;
    }

    @GetMapping
    public ResponseEntity<List<Comment>> getAllComments() {
        try {
            List<Comment> comments = commentService.list();
            return ResponseEntity.ok(comments);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Comment> getComment(@PathVariable Long id) {
        try {
            Comment comment = commentService.select(id);
            if (comment == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(comment);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @PostMapping
    public ResponseEntity<String> createComment(@RequestBody Comment comment) {
        try {
            boolean success = commentService.insert(comment);
            if (success) {
                return ResponseEntity.ok("Comment created");
            }
            return ResponseEntity.status(500).body("Failed to create comment");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to create comment: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateComment(@PathVariable Long id, @RequestBody Comment comment) {
        try {
            comment.setId(id);
            boolean success = commentService.update(comment);
            if (success) {
                return ResponseEntity.ok("Comment updated");
            }
            return ResponseEntity.status(500).body("Failed to update comment");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to update comment: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteComment(@PathVariable Long id) {
        try {
            boolean success = commentService.delete(id);
            if (success) {
                return ResponseEntity.ok("Comment deleted");
            }
            return ResponseEntity.status(500).body("Failed to delete comment");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to delete comment: " + e.getMessage());
        }
    }

    // 특정 type과 targetId에 대한 댓글 목록 조회
    @GetMapping("/target")
    public ResponseEntity<List<Comment>> getCommentsByTarget(
            @RequestParam String type,
            @RequestParam Long targetId) {
        try {
            List<Comment> comments = commentService.findByTarget(type, targetId);
            return ResponseEntity.ok(comments);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }
}
