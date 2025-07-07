package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.Artist;

@Mapper
public interface ArtistMapper {
    // 목록
    public List<Artist> list() throws Exception;
    // 단건 조회
    public Artist selectById(String id) throws Exception;
    // 삽입
    public int insert(Artist artist) throws Exception;
    // 수정
    public int update(Artist artist) throws Exception;
    // 삭제
    public int delete(String id) throws Exception;
    // 존재 여부 확인
    public int exists(String id) throws Exception;
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
    // 전체 수
    public long count() throws Exception;
    // 앨범아이디로 아티스트객체
    public Artist findArtistByAlbumId(String id) throws Exception;
}
