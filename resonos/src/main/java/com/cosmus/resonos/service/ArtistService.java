package com.cosmus.resonos.service;

import java.util.List;

import com.cosmus.resonos.domain.Artist;

public interface ArtistService {
    // 목록
    public List<Artist> list() throws Exception;
    // 조회
    public Artist select(Integer no) throws Exception;
    // 삽입
    public boolean insert(Artist artist) throws Exception;
    // 수정
    public boolean update(Artist artist) throws Exception;
    // 삭제
    public boolean delete(String id) throws Exception;
    // 존재 여부 확인
    public boolean exists(String id) throws Exception;
}
