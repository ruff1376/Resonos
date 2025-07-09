package com.cosmus.resonos.service;

import com.cosmus.resonos.domain.AlbumMoodVote;
import com.cosmus.resonos.mapper.AlbumMoodVoteMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AlbumMoodVoteServiceImpl implements AlbumMoodVoteService {

    private final AlbumMoodVoteMapper albumMoodVoteMapper;

    public AlbumMoodVoteServiceImpl(AlbumMoodVoteMapper albumMoodVoteMapper) {
        this.albumMoodVoteMapper = albumMoodVoteMapper;
    }

    @Override
    public int insert(AlbumMoodVote vote) {
        return albumMoodVoteMapper.insert(vote);
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
    public List<Map<String, Object>> getAlbumMoodStats() {
        return albumMoodVoteMapper.getAlbumMoodStats();
    }
}
