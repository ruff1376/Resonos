package com.cosmus.resonos.domain.Album;

import java.time.LocalDateTime;

import com.cosmus.resonos.domain.Review.Reviewer;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class AlbumReview {
    // 리뷰 아이디
    private Long id;
    /**
     * 평점 ‑ 0 ~ 100 (백분율)
     */
    private Integer rating;

    /**
     * 리뷰 본문
     */
    private String content;

    /**
     * true = 블라인드 처리됨
     */
    private Boolean blinded;

    private Integer likes;
    private Integer dislikes;

    private LocalDateTime createdAt;

    /**
     * true = "Critic" 권한(신뢰 리뷰어)
     */
    private Boolean critic;

    /**
     * 작성자 FK
     */
    private Long userId;

    /**
     * 앨범 FK (Spotify ID 등 문자열)
     */
    private String albumId;

    private Reviewer reviewer;  // 연관된 Reviewer 정보 포함
    // 좋아요누른 유저인지 확인
    private Boolean isLikedByCurrentUser;

    /* 앨범 명 */
    private String title;


}
