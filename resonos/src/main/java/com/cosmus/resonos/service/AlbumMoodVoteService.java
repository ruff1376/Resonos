package com.cosmus.resonos.service;

import com.cosmus.resonos.domain.AlbumMoodVote;

import java.util.List;
import java.util.Map;

public interface AlbumMoodVoteService {

    List<Map<String, Object>> getAlbumMoodStats();

    List<AlbumMoodVote> findAll();

    List<AlbumMoodVote> findByAlbumId(String albumId);

    void saveOrUpdateVote(Long userId, String albumId, Long moodId);

    Long getUserVotedMoodId(Long userId, String albumId);
}
