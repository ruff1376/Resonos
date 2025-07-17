package com.cosmus.resonos.service;

import com.cosmus.resonos.domain.ChartElement;
import com.cosmus.resonos.mapper.ChartElementMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
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
    public Map<String, Integer> getAverageScoresByAlbumId(String albumId) {
        Map<String, Object> raw = chartElementMapper.getAverageScoresByAlbumId(albumId);

        Map<String, Integer> result = new HashMap<>();
        if (raw == null) {
            return null;
        }

        for (Map.Entry<String, Object> entry : raw.entrySet()) {
            Object value = entry.getValue();
            int intValue = 0;

            if (value instanceof Number) {
                intValue = ((Number) value).intValue();
                if (intValue < 0) {
                    intValue = 0;
                } else if (intValue > 100) {
                    intValue = 100;
                }
            }

            result.put(entry.getKey(), intValue);
        }

        return result;
    }
}
