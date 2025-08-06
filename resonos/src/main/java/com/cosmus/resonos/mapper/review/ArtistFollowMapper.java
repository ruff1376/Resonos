package com.cosmus.resonos.mapper.review;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.review.ArtistFollow;

@Mapper
public interface ArtistFollowMapper {
    // 전체 조회
    public List<ArtistFollow> list() throws Exception;
    // 조회
    public ArtistFollow select(String id) throws Exception;
    // 삽입
    public int insert(ArtistFollow artistFollow) throws Exception;
    // 수정
    public int update(ArtistFollow artistFollow) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    // 해당 아티스트의 팔로우 수
    int countByArtistId(@Param("artistId") String artistId);
    // 유저아이디와 아티스트아이디로 팔로우 여부 객체 반환
    ArtistFollow findByUserAndArtist(@Param("userId") Long userId, @Param("artistId") String artistId);
}
