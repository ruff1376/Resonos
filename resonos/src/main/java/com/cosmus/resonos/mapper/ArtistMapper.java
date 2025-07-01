package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.Artist;
@Mapper
public interface ArtistMapper {
    public List<Artist> selectAll();
    public Artist selectById(String id);
    public int insert(Artist artist);
    public int update(Artist artist);
    public int delete(String id);
}
