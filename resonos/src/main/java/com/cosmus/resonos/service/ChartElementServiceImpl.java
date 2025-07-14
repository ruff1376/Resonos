package com.cosmus.resonos.service;

import com.cosmus.resonos.domain.ChartElement;
import com.cosmus.resonos.mapper.ChartElementMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class ChartElementServiceImpl implements ChartElementService {

    @Autowired
    private ChartElementMapper chartElementMapper;

    @Override
    public void saveOrUpdate(ChartElement element) {
        ChartElement existing = chartElementMapper.findByUserAndAlbum(element.getUserId(), element.getAlbumId());
        if (existing != null) {
            element.setId(existing.getId());
            chartElementMapper.update(element);
        } else {
            chartElementMapper.insert(element);
        }
    }

    @Override
    public ChartElement getUserVote(Long userId, String albumId) {
        return chartElementMapper.findByUserAndAlbum(userId, albumId);
    }

    @Override
    public Map<String, Object> getAverageScores(String albumId) {
        return chartElementMapper.getAverageScoresByAlbumId(albumId);
    }
}
