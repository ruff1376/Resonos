package com.cosmus.resonos.mapper.review;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.Vote.MoodStat;

@Mapper
public interface MoodStatMapper {

    public List<MoodStat> getTop6MoodsByTrackId(String trackId);

    public List<MoodStat> getTop6MoodsByArtistId(String artistId);

}
