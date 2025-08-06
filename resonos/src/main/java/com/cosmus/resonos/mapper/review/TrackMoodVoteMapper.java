package com.cosmus.resonos.mapper.review;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.Track.TrackMoodVote;
@Mapper
public interface TrackMoodVoteMapper {
    // 트랙별 태그/분위기 투표 현황 (trackId, mood, count)
    List<Map<String, Object>> getTrackMoodStats();

    // 전체 투표 목록
    List<TrackMoodVote> findAll();

    // 특정 트랙 투표 목록
    List<TrackMoodVote> findByTrackId(String trackId);

    // 투표시 중복처리 유저아이디,트랙아이디조건으로
    TrackMoodVote findByUserAndTrack(@Param("userId")Long userId, @Param("trackId") String trackId);

    // 등록
    void insert(TrackMoodVote vote);

    // 수정
    void update(TrackMoodVote vote);
}
