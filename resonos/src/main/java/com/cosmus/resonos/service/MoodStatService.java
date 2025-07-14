package com.cosmus.resonos.service;

import java.util.List;

import com.cosmus.resonos.domain.MoodStat;

public interface MoodStatService {
    
    public List<MoodStat> getTop6MoodsByTrackId(String trackId);

    public List<MoodStat> getTop6MoodsByArtistId(String artistId);
}
