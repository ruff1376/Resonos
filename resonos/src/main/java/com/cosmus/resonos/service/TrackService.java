package com.cosmus.resonos.service;

import java.util.List;

import com.cosmus.resonos.domain.Track;
public interface TrackService {
    // 목록
    public List<Track> list() throws Exception;
    // 메인 화면 최신 트랙 목록
    public List<Track> mainNewList() throws Exception;
    // 조회
    public Track select(Integer no) throws Exception;
    // 삽입
    public boolean insert(Track artist) throws Exception;
    // 수정
    public boolean update(Track artist) throws Exception;
    // 삭제
    public boolean delete(String id) throws Exception;
    // 존재 여부 확인
    public boolean exists(String id) throws Exception;
    
    // 동기화: Spotify에서 트랙 정보를 가져와서 데이터베이스에 저장
    public void syncTrackFromSpotify(String spotifyTrackId);
}
