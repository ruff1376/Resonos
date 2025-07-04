package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Pagination;

@Mapper
public interface AlbumMapper {
    // 목록
    public List<Album> list() throws Exception;
    // 메인 화면 최신 앨범 목록
    public List<Album> mainNewList() throws Exception;
    // 최신 앨범 목록
    public List<Album> newList(Pagination pagination) throws Exception;
    // 데이터 수
    public long count() throws Exception;
    // 조회
    public Album select(Integer no) throws Exception;
    // 삽입
    public int insert(Album album) throws Exception;
    // 수정
    public int update(Album album) throws Exception;
    // 삭제
    public int delete(String id) throws Exception;
    // 존재 여부 확인
    public int exists(String id) throws Exception;
    // 아티스트아이디로 앨범 전체조회
    public List<Album> findAlbumsByArtistId(String id) throws Exception;
    // 아티스트 아이디로 앨범 개수 확인
    public int countAlbumsByArtist(String id) throws Exception;
}
