package com.cosmus.resonos.service;

import java.util.List;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Pagination;


public interface AlbumService {
    // 목록
    public List<Album> list() throws Exception;
    // 메인 화면 최신 앨범 목록
    public List<Album> mainNewList() throws Exception;
    // 최신 앨범 전체 목록
    public List<Album> newList(Pagination pagination) throws Exception;
    // 조회
    public Album select(Integer no) throws Exception;
    // 삽입
    public boolean insert(Album track) throws Exception;
    // 수정
    public boolean update(Album track) throws Exception;
    // 삭제
    public boolean delete(String id) throws Exception;
}
