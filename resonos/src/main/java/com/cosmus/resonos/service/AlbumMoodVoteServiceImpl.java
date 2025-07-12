package com.cosmus.resonos.service;

import com.cosmus.resonos.domain.AlbumMoodVote;
import com.cosmus.resonos.mapper.AlbumMoodVoteMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AlbumMoodVoteServiceImpl implements AlbumMoodVoteService {

    @Autowired
    private AlbumMoodVoteMapper albumMoodVoteMapper;

    @Override
    public List<Map<String, Object>> getAlbumMoodStats() {
        return albumMoodVoteMapper.getAlbumMoodStats();
    }

    @Override
    public List<AlbumMoodVote> findAll() {
        return albumMoodVoteMapper.findAll();
    }

    @Override
    public List<AlbumMoodVote> findByAlbumId(String albumId) {
        return albumMoodVoteMapper.findByAlbumId(albumId);
    }

    @Override
    public void saveOrUpdateVote(Long userId, String albumId, Long moodId) {
        AlbumMoodVote existing = albumMoodVoteMapper.findByUserAndAlbum(userId, albumId);
        if (existing != null) {
            existing.setMood(moodId);
            albumMoodVoteMapper.update(existing);
        } else {
            AlbumMoodVote vote = new AlbumMoodVote();
            vote.setUserId(userId);
            vote.setAlbumId(albumId);
            vote.setMood(moodId);
            albumMoodVoteMapper.insert(vote);
        }
    }

    @Override
    public Long getUserVotedMoodId(Long userId, String albumId) {
        AlbumMoodVote vote = albumMoodVoteMapper.findByUserAndAlbum(userId, albumId);
    return vote != null ? vote.getMood() : null;
    }
}
