package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.Album;
@Mapper
public interface AlbumMapper {
    public List<Album> selectAll();
    public Album selectById(String id);
    public int insert(Album album);
    public int update(Album album);
    public int delete(String id);
}
