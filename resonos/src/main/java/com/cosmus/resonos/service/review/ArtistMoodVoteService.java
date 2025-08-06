package com.cosmus.resonos.service.review;

import java.util.List;
import java.util.Map;

import com.cosmus.resonos.domain.Artist.ArtistMoodVote;

public interface ArtistMoodVoteService {

    // 아티스트 분위기 통계
    List<Map<String, Object>> getArtistMoodStats();

    // 전체 투표 목록
    List<ArtistMoodVote> findAll();

    // 특정 아티스트에 대한 모든 투표 조회
    List<ArtistMoodVote> findByArtistId(String artistId);

    // 유저가 투표한 무드를 삽입 또는 업데이트
    void saveOrUpdateVote(Long userId, String artistId, Long moodId);

    // 유저가 해당 아티스트에 대해 투표한 moodId 조회
    Long getUserVotedMoodId(Long userId, String artistId);
}
