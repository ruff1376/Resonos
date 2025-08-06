package com.cosmus.resonos.service.user;

import java.util.List;

import com.cosmus.resonos.domain.review.LikedPlaylist;

public interface LikedPlaylistService {
    // 전체 조회
    public List<LikedPlaylist> list() throws Exception;
    // 조회
    public LikedPlaylist select(Long id) throws Exception;
    // 삽입
    public boolean insert(LikedPlaylist likedPlaylist) throws Exception;
    // 수정
    public boolean update(LikedPlaylist likedPlaylist) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
}
