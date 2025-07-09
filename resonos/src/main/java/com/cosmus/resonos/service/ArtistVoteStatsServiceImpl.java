package com.cosmus.resonos.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.mapper.ArtistVoteStatsMapper;

import java.util.List;
import java.util.Map;

@Service
public class ArtistVoteStatsServiceImpl implements ArtistVoteStatsService {
    @Autowired
    private ArtistVoteStatsMapper artistVoteStatsMapper;

    @Override
    public List<Map<String, Object>> getArtistMoodVoteStats() {
        return artistVoteStatsMapper.getArtistMoodVoteStats();
    }
}
