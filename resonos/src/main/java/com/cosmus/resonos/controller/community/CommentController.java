package com.cosmus.resonos.controller.community;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.community.Comment;
import com.cosmus.resonos.service.badge.BadgeGrantService;
import com.cosmus.resonos.service.community.CommentService;

@RestController
@RequestMapping("/comments")
public class CommentController {

    private final CommentService commentService;

    @Autowired
    private BadgeGrantService badgeGrantService;


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
    public ResponseEntity<String> createComment(@RequestBody Comment comment,
                                                @AuthenticationPrincipal CustomUser customUser) {
        try {
            // 1. 댓글 저장 서비스 호출
            boolean success = commentService.insert(comment);

            // 2. 댓글 저장 성공 시 배지 자동 지급 트리거
            if (success && customUser != null) {
                // customUser.getUser().getId()로 현재 로그인 유저의 id 추출
                badgeGrantService.checkAndGrantBadges(customUser.getUser().getId());
            }

            // 3. 성공 응답 반환
            if (success) {
                return ResponseEntity.ok("Comment created");
            }
            // 4. 실패 시 500 반환
            return ResponseEntity.status(500).body("Failed to create comment");
        } catch (Exception e) {
            // 5. 예외 발생 시 에러 메시지와 함께 500 반환
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
