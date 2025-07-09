package com.cosmus.resonos.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.TrackMoodVote;
@Mapper
public interface TrackMoodVoteMapper {
    // 트랙별 태그/분위기 투표 현황 (trackId, mood, count)
    List<Map<String, Object>> getTrackMoodStats();

    // 전체 투표 목록
    List<TrackMoodVote> findAll();

    // 특정 트랙 투표 목록
    List<TrackMoodVote> findByTrackId(String trackId);
}
