package com.cosmus.resonos.domain;

import lombok.*;
import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TrackReview {
    private Long id;

    /**
     * 평점 ‑ 0 ~ 100 (백분율)
     */
    private Float rating;

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
     * 트랙 FK (Spotify ID 등 문자열)
     */
    private String trackId;
}
