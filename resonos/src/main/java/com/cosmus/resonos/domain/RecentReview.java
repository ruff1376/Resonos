package com.cosmus.resonos.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class RecentReview {
    private String id; // 트랙이나 앨범의 아이디
    private String name; // 트랙이나 앨범의 타이틀
    private String content; // 리뷰내용
    private int likeCount; // 해당 리뷰의 좋아요 수
    private LocalDateTime createdAt; // 리뷰등록 시기
    private String type;   // "TRACK" or "ALBUM"
}
