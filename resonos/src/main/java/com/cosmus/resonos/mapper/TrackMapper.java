package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.Track;
@Mapper
public interface TrackMapper {
    public List<Track> selectAll();
    public Track selectById(String id);
    public int insert(Track track);
    public int update(Track track);
    public int delete(String id);
}
