package com.cosmus.resonos.mapper;

import com.cosmus.resonos.domain.AlbumMoodVote;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface AlbumMoodVoteMapper {

    // 앨범별 분위기 투표 통계
    List<Map<String, Object>> getAlbumMoodStats();

    // 전체 투표 조회
    List<AlbumMoodVote> findAll();

    // 앨범별 투표 전체 조회
    List<AlbumMoodVote> findByAlbumId(String albumId);

    // 유저가 특정 앨범에 대해 투표했는지 조회
    AlbumMoodVote findByUserAndAlbum(@Param("userId")Long userId, @Param("albumId") String albumId);

    // 신규 투표 삽입
    void insert(AlbumMoodVote vote);

    // 기존 투표 수정
    void update(AlbumMoodVote vote);
}
