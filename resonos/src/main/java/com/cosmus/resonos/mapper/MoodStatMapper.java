package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.MoodStat;

@Mapper
public interface MoodStatMapper {
    
    public List<MoodStat> getTop6MoodsByTrackId(String trackId);

}
