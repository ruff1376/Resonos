package com.cosmus.resonos.service;

import java.util.List;
import java.util.Map;

import com.cosmus.resonos.domain.TrackMoodVote;

public interface TrackMoodVoteService {
    List<Map<String, Object>> getTrackMoodStats();

    List<TrackMoodVote> findAll();

    List<TrackMoodVote> findByTrackId(String trackId);
}
