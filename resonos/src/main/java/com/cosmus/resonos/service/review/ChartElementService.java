package com.cosmus.resonos.service.review;

import java.util.Map;

import com.cosmus.resonos.domain.review.ChartElement;

public interface ChartElementService {

    void saveOrUpdate(ChartElement element);

    ChartElement getUserVote(Long userId, String albumId);

    Map<String, Integer> getAverageScoresByAlbumId(String albumId);
}
