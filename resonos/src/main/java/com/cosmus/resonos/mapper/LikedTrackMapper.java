package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.LikedTrack;

@Mapper
public interface LikedTrackMapper {
    // 전체 조회
    public List<LikedTrack> list() throws Exception;
    // 조회
    public LikedTrack select(Long id) throws Exception;
    // 삽입
    public int insert(LikedTrack likedTrack) throws Exception;
    // 수정
    public int update(LikedTrack likedTrack) throws Exception;
    // 삭제
    public int deleteById(Long id) throws Exception;
    // 해당 트랙의 좋아요 수
    int countByTrackId(@Param("trackId") String trackId);
    // 단건 조회 (사용자 + 트랙)
    LikedTrack findByUserAndTrack(@Param("userId") Long userId, @Param("trackId") String trackId);
    
}
