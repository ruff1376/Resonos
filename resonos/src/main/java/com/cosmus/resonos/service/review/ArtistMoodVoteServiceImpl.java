package com.cosmus.resonos.service.review;

import com.cosmus.resonos.domain.review.ArtistMoodVote;
import com.cosmus.resonos.mapper.review.ArtistMoodVoteMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ArtistMoodVoteServiceImpl implements ArtistMoodVoteService {

    @Autowired
    private ArtistMoodVoteMapper artistMoodVoteMapper;

    @Override
    public List<Map<String, Object>> getArtistMoodStats() {
        return artistMoodVoteMapper.getArtistMoodStats();
    }

    @Override
    public List<ArtistMoodVote> findAll() {
        return artistMoodVoteMapper.findAll();
    }

    @Override
    public List<ArtistMoodVote> findByArtistId(String artistId) {
        return artistMoodVoteMapper.findByArtistId(artistId);
    }

    @Override
    public void saveOrUpdateVote(Long userId, String artistId, Long moodId) {
        ArtistMoodVote existing = artistMoodVoteMapper.findByUserAndArtist(userId, artistId);
        if (existing != null) {
            existing.setMood(moodId);
            artistMoodVoteMapper.update(existing);
        } else {
            ArtistMoodVote vote = new ArtistMoodVote();
            vote.setUserId(userId);
            vote.setArtistId(artistId);
            vote.setMood(moodId);
            artistMoodVoteMapper.insert(vote);
        }
    }

    @Override
    public Long getUserVotedMoodId(Long userId, String artistId) {
        ArtistMoodVote vote = artistMoodVoteMapper.findByUserAndArtist(userId, artistId);
        return vote != null ? vote.getMood() : null;
    }
}
