package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.Artist;

@Mapper
public interface ArtistMapper {
    // 목록
    public List<Artist> list() throws Exception;
    // 조회
    public Artist select(Integer no) throws Exception;
    // 삽입
    public int insert(Artist artist) throws Exception;
    // 수정
    public int update(Artist artist) throws Exception;
    // 삭제
    public int delete(String id) throws Exception;
}
