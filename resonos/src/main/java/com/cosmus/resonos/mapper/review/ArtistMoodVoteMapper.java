package com.cosmus.resonos.mapper.review;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.review.ArtistMoodVote;

import java.util.List;
import java.util.Map;

@Mapper
public interface ArtistMoodVoteMapper {

    // 아티스트별 분위기 투표 통계
    List<Map<String, Object>> getArtistMoodStats();

    // 전체 투표 조회
    List<ArtistMoodVote> findAll();

    // 아티스트별 투표 전체 조회
    List<ArtistMoodVote> findByArtistId(String artistId);

    // 유저가 특정 아티스트에 대해 투표했는지 조회
    ArtistMoodVote findByUserAndArtist(@Param("userId") Long userId, @Param("artistId") String artistId);

    // 신규 투표 삽입
    void insert(ArtistMoodVote vote);

    // 기존 투표 수정
    void update(ArtistMoodVote vote);
}
