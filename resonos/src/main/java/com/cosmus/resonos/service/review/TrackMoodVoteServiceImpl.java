package com.cosmus.resonos.service.review;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Track.TrackMoodVote;
import com.cosmus.resonos.mapper.review.TrackMoodVoteMapper;

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

    @Override
    public void saveOrUpdateVote(Long userId, String trackId, Long moodId) {
        TrackMoodVote existing = trackMoodVoteMapper.findByUserAndTrack(userId, trackId);
        if (existing != null) {
            existing.setMood(moodId);
            trackMoodVoteMapper.update(existing);
        } else {
            TrackMoodVote vote = new TrackMoodVote();
            vote.setUserId(userId);
            vote.setTrackId(trackId);
            vote.setMood(moodId);
            trackMoodVoteMapper.insert(vote);
        }
    }

    @Override
    public Long getUserVotedMoodId(Long userId, String trackId) {
        TrackMoodVote vote = trackMoodVoteMapper.findByUserAndTrack(userId, trackId);
    return vote != null ? vote.getMood() : null;
    }
}
