package com.cosmus.resonos.service.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.review.MoodStat;
import com.cosmus.resonos.mapper.review.MoodStatMapper;

@Service
public class MoodStatServiceImpl implements MoodStatService {

    @Autowired
    private MoodStatMapper moodStatMapper;

    @Override
    public List<MoodStat> getTop6MoodsByTrackId(String trackId) {
        return moodStatMapper.getTop6MoodsByTrackId(trackId);
    }

    @Override
    public List<MoodStat> getTop6MoodsByArtistId(String artistId) {
        return moodStatMapper.getTop6MoodsByArtistId(artistId);
    }


}
