package com.cosmus.resonos.service;

import java.util.List;
import java.util.Map;

import com.cosmus.resonos.domain.TrackMoodVote;

public interface TrackMoodVoteService {
    List<Map<String, Object>> getTrackMoodStats();

    List<TrackMoodVote> findAll();

    List<TrackMoodVote> findByTrackId(String trackId);

    // 등록전에 이미 투표한 트랙인지 확인하고 없으면 등록 있다면 업데이트
    void saveOrUpdateVote(Long userId, String trackId, Long moodId);
    // 투표후 어디에 투표했는지 확인용
    public Long getUserVotedMoodId(Long userId, String trackId);
}
