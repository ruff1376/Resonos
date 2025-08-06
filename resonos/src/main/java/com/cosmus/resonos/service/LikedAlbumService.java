package com.cosmus.resonos.service;

import java.util.List;

import com.cosmus.resonos.domain.Album.LikedAlbum;

public interface LikedAlbumService {
    // 전체 조회
    List<LikedAlbum> list() throws Exception;

    // 단건 조회
    LikedAlbum select(Long id) throws Exception;

    // 삽입
    boolean insert(LikedAlbum likedAlbum) throws Exception;

    // 수정
    boolean update(LikedAlbum likedAlbum) throws Exception;

    // 삭제
    boolean deleteById(Long id) throws Exception;

    // 좋아요 토글
    boolean toggleLike(Long userId, String albumId) throws Exception;

    // 로그인 유저가 해당 앨범 좋아요했는지 확인
    boolean isLikedByUser(Long userId, String albumId);

    // 앨범의 좋아요 수
    int getAlbumLikeCount(String albumId);
}
