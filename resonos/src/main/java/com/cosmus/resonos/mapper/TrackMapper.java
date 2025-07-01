package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.Track;

@Mapper
public interface TrackMapper {
    // 목록
    public List<Track> list() throws Exception;
    // 조회
    public Track select(Integer no) throws Exception;
    // 삽입
    public int insert(Track track) throws Exception;
    // 수정
    public int update(Track track) throws Exception;
    // 삭제
    public int delete(String id) throws Exception;
}
