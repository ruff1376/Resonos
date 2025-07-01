package com.cosmus.resonos.service;

import java.util.List;

import com.cosmus.resonos.domain.Album;


public interface AlbumService {
    // 목록
    public List<Album> list() throws Exception;
    // 조회
    public Album select(Integer no) throws Exception;
    // 삽입
    public boolean insert(Album track) throws Exception;
    // 수정
    public boolean update(Album track) throws Exception;
    // 삭제
    public boolean delete(String id) throws Exception;
}
