package com.cosmus.resonos.service.user;

import java.util.List;

import com.cosmus.resonos.domain.review.LikedTrack;

public interface LikedTrackService {
    // 전체 조회
    public List<LikedTrack> list() throws Exception;
    // 조회
    public LikedTrack select(Long id) throws Exception;
    // 삽입
    public boolean insert(LikedTrack likedTrack) throws Exception;
    // 수정
    public boolean update(LikedTrack likedTrack) throws Exception;
    // 삭제
    public boolean deleteById(Long id) throws Exception;
    // 좋아요 여부확인후 처리
    boolean toggleLike(Long userId, String trackId) throws Exception;
    // 단건조회후 로그인유저의 좋아요여부를 확인
    boolean isLikedByUser(Long userId, String trackId);
    // 트랙의 좋아요수 확인
    int getTrackLikeCount(String trackId);
}
