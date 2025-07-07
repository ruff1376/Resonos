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

    // 1. spotify에서 api에서 아티스트 정보를 가져오기
    public Artist getArtistFromSpotify(String artistId) throws Exception;

    // 2. artist 도메인으로 변환 후 DB에 저장/업데이트
    public Artist saveOrUpdateArtist(Artist artist) throws Exception;

    // 해당 아티스트의 인기1위 mv url을 반환
    public String selectTopMvUrlByArtist(String id) throws Exception;

    // 트랙 아이디로 아티스트 객체 반환
    public Artist selectArtistByTrackId(String id) throws Exception;

    // 페이징 처리된 아티스트 목록 조회
    public List<Artist> listPaging(int offset, int size) throws Exception;


    // 검색 결과 목록
    public List<Artist> searchList(String keyword) throws Exception;
    // 검색 결과 전체 목록
    public List<Artist> allSearchList(String keyword) throws Exception;

<<<<<<< HEAD
    // 전체 수
    public long count() throws Exception;
=======
    // 앨범아이디로 아티스트객체
    public Artist findArtistByAlbumId(String id) throws Exception;
>>>>>>> 47db840545b0b189ecabde33086371b37b2a7109
}
