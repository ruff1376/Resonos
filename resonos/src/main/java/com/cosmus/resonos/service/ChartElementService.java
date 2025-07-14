package com.cosmus.resonos.service;

import com.cosmus.resonos.domain.ChartElement;

import java.util.Map;

public interface ChartElementService {

    void saveOrUpdate(ChartElement element);

    ChartElement getUserVote(Long userId, String albumId);

    Map<String, Integer> getAverageScoresByAlbumId(String albumId);
}
