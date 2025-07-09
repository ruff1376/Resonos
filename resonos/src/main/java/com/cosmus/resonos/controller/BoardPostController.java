package com.cosmus.resonos.controller;

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
import org.springframework.web.bind.annotation.RestController;

import com.cosmus.resonos.domain.BoardPost;
import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.service.BadgeGrantService;
import com.cosmus.resonos.service.BoardPostService;

@RestController
@RequestMapping("/board-posts")
public class BoardPostController {

    private final BoardPostService boardPostService;

    @Autowired
    private BadgeGrantService badgeGrantService;


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
    public ResponseEntity<String> createPost(@RequestBody BoardPost post,
                                            @AuthenticationPrincipal CustomUser customUser) {
        try {
            // 1. 게시글 저장 서비스 호출
            boolean success = boardPostService.insert(post);

            // 2. 게시글 저장 성공 시 배지 자동 지급 트리거
            if (success && customUser != null) {
                // customUser.getUser().getId()로 현재 로그인 유저의 id 추출
                badgeGrantService.checkAndGrantBadges(customUser.getUser().getId());
            }

            // 3. 성공 응답 반환
            if (success) {
                return ResponseEntity.ok("Board post created");
            }
            // 4. 실패 시 500 반환
            return ResponseEntity.status(500).body("Failed to create board post");
        } catch (Exception e) {
            // 5. 예외 발생 시 에러 메시지와 함께 500 반환
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
