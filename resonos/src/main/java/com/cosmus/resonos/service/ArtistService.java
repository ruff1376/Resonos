package com.cosmus.resonos.service;

import java.util.List;

import com.cosmus.resonos.domain.Artist;

public interface ArtistService {
    // 목록
    public List<Artist> list() throws Exception;
    // 아티스트 단건 조회
    public Artist selectById(String id) throws Exception;
    // 삽입
    public boolean insert(Artist artist) throws Exception;
    // 수정
    public boolean update(Artist artist) throws Exception;
    // 삭제
    public boolean delete(String id) throws Exception;
    // 존재 여부 확인
    public boolean exists(String id) throws Exception;
    // 해당 아티스트의 인기1위 mv url을 반환
    public String selectTopMvUrlByArtist(String id) throws Exception;
}
