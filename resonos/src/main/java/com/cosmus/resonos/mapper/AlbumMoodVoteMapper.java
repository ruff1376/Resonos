package com.cosmus.resonos.mapper;

import com.cosmus.resonos.domain.AlbumMoodVote;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface AlbumMoodVoteMapper {
    public int insert(AlbumMoodVote vote);
    public List<AlbumMoodVote> findAll();
    public List<AlbumMoodVote> findByAlbumId(String albumId);
    public List<Map<String, Object>> getAlbumMoodStats(); // 앨범별 태그/분위기 투표 현황
}
