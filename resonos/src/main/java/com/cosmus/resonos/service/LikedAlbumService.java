package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.LikedAlbum;

public interface LikedAlbumService {
    // 전체 조회
    public List<LikedAlbum> list() throws Exception;
    // 조회
    public LikedAlbum select(Long id) throws Exception;
    // 삽입
    public boolean insert(LikedAlbum likedAlbum) throws Exception;
    // 수정
    public boolean update(LikedAlbum likedAlbum) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
}
