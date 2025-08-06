package com.cosmus.resonos.domain.Track;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class TrackReviewLike {
    // PK
    private Long id;
    // 리뷰 외래키
    private Long reviewId;
    // 유저 아이디 외래키
    private Long userId;
    private LocalDateTime createdAt;
}
