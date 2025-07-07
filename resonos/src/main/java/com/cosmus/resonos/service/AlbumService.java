package com.cosmus.resonos.service;

import java.util.List;
import java.util.Map;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Pagination;


public interface AlbumService {
    // 목록
    public List<Album> list() throws Exception;
    // 메인 화면 최신 앨범 목록
    public List<Album> mainNewList() throws Exception;
    // 아티스트아이디로 앨범 전체조회
    public List<Album> findAlbumsByArtistId(String id) throws Exception;
    // 최신 앨범 전체 목록
    public List<Album> newList(Pagination pagination) throws Exception;
    // 조회
    public Album select(String id) throws Exception;
    // 삽입
    public boolean insert(Album track) throws Exception;
    // 수정
    public boolean update(Album track) throws Exception;
    // 삭제
    public boolean delete(String id) throws Exception;
    // 존재 여부 확인
    public boolean exists(String id) throws Exception;
    // 아티스트 아이디로 앨범 개수 확인
    public int countAlbumsByArtist(String id) throws Exception;
    // 트랙 아이디로 앨범 객체
    public Album findAlbumByTrackId(String id) throws Exception;
    // 검색 결과 목록
    public List<Album> searchList(String keyword) throws Exception;
    // 검색 결과 전체 목록
    public List<Album> allSearchList(Map<String, Object> paramMap) throws Exception;
}
