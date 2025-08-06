package com.cosmus.resonos.service.review;

import java.util.List;

import com.cosmus.resonos.domain.Vote.MoodStat;

public interface MoodStatService {

    public List<MoodStat> getTop6MoodsByTrackId(String trackId);

    public List<MoodStat> getTop6MoodsByArtistId(String artistId);
}
