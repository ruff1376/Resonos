package com.cosmus.resonos.mapper.user;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.review.LikedPlaylist;

@Mapper
public interface LikedPlaylistMapper {
    // 전체 조회
    public List<LikedPlaylist> list() throws Exception;
    // 조회
    public LikedPlaylist select(Long id) throws Exception;
    // 삽입
    public int insert(LikedPlaylist likedPlaylist) throws Exception;
    // 수정
    public int update(LikedPlaylist likedPlaylist) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
}
