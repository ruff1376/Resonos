package com.cosmus.resonos.mapper.review;

import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map;

@Mapper
public interface ArtistVoteStatsMapper {
    List<Map<String, Object>> getArtistMoodVoteStats();
}
