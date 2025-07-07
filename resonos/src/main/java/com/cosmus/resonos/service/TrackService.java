package com.cosmus.resonos.service;

import java.util.List;

import com.cosmus.resonos.domain.Track;
public interface TrackService {
    // 목록
    public List<Track> list() throws Exception;
    // 메인 화면 최신 트랙 목록
    public List<Track> mainNewList() throws Exception;
    // 조회
    public Track selectById(String id) throws Exception;
    // 삽입
    public boolean insert(Track artist) throws Exception;
    // 수정
    public boolean update(Track artist) throws Exception;
    // 삭제
    public boolean delete(String id) throws Exception;
    // 존재 여부 확인
    public boolean exists(String id) throws Exception;
    // 아티스트별 상위7개 인기곡
    public List<Track> selectTop7TracksByArtist(String id) throws Exception;
    // 아티스트아이디당 트랙갯수
    public int countTracksByArtist(String id) throws Exception;
    // 트랙아이디로 같은앨범 상위5곡
    public List<Track> findTop5TracksInSameAlbum(String id) throws Exception;
    // 트랙아이디로 아티스트이름
    public String findArtistNameByTrackId(String id) throws Exception;
    // 검색 결과 목록
    public List<Track> searchList(String keyword) throws Exception;
    // 검색 결과 전체 목록
    public List<Track> allSearchList(String keyword) throws Exception;
}
