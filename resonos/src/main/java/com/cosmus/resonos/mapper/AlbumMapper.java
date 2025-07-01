package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.Album;

@Mapper
public interface AlbumMapper {
    // 목록
    public List<Album> list() throws Exception;
    // 조회
    public Album select(Integer no) throws Exception;
}
