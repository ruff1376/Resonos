package com.cosmus.resonos.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.TrackMoodVote;
import com.cosmus.resonos.mapper.TrackMoodVoteMapper;

@Service
public class TrackMoodVoteServiceImpl implements TrackMoodVoteService {

    @Autowired
    private TrackMoodVoteMapper trackMoodVoteMapper;

    @Override
    public List<Map<String, Object>> getTrackMoodStats() {
        return trackMoodVoteMapper.getTrackMoodStats();
    }

    @Override
    public List<TrackMoodVote> findAll() {
        return trackMoodVoteMapper.findAll();
    }

    @Override
    public List<TrackMoodVote> findByTrackId(String trackId) {
        return trackMoodVoteMapper.findByTrackId(trackId);
    }
}
