package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.ArtistFollow;

public interface ArtistFollowService {
    // 전체 조회
    public List<ArtistFollow> list() throws Exception;
    // 조회
    public ArtistFollow select(String id) throws Exception;
    // 삽입
    public boolean insert(ArtistFollow artistFollow) throws Exception;
    // 수정 
    public boolean update(ArtistFollow artistFollow) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
    // 팔로우 여부확인후 팔로우,팔로우 취소 처리
    boolean toggleLike(Long userId, String artistId) throws Exception;
    // 단건 조회 후 로그인 유저의 좋아요 여부 확인
    boolean isLikedByUser(Long userId, String artistId) throws Exception;
    // 아티스트의 팔로우 수 확인
    int getArtistFollowCount(String artistId);
}
