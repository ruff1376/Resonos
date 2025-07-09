package com.cosmus.resonos.service;

import com.cosmus.resonos.domain.AlbumMoodVote;

import java.util.List;
import java.util.Map;

public interface AlbumMoodVoteService {
    public int insert(AlbumMoodVote vote);
    public List<AlbumMoodVote> findAll();
    public List<AlbumMoodVote> findByAlbumId(String albumId);
    public List<Map<String, Object>> getAlbumMoodStats();
}
