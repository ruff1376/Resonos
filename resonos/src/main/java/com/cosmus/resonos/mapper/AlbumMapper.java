package com.cosmus.resonos.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Pagination;

@Mapper
public interface AlbumMapper {
    // 목록
    public List<Album> list() throws Exception;
    // 국내 리뷰 급상승 앨범 목록
    public List<Album> korHotReviewList() throws Exception;
    // 해외 리뷰 급상승 앨범 목록
    public List<Album> worldHotReviewList() throws Exception;
    // 메인 화면 최신 앨범 목록
    public List<Album> mainNewList() throws Exception;
    // 최신 앨범 목록
    public List<Album> newList(Pagination pagination) throws Exception;
    // 메인 화면 인기 앨범 목록
    public List<Album> mainHotList() throws Exception;
    // 인기 앨범 목록
    public List<Album> hotList(Pagination pagination) throws Exception;
    // 데이터 수
    public long count() throws Exception;
    // 최신 데이터 수
    public long newCount() throws Exception;
    // 인기 데이터 수
    public long hotCount() throws Exception;
    // 조회
    public Album select(String id) throws Exception;
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
    // 트랙 아이디로 앨범 객체
    public Album findAlbumByTrackId(String id) throws Exception;
    // 검색 결과 목록
    public List<Album> searchList(@Param("keyword") String keyword) throws Exception;
    // 검색 결과 전체 목록
    public List<Album> allSearchList(
        @Param("keyword") String keyword,
        @Param("pagination") Pagination pagination,
        @Param("sort") String sort
    ) throws Exception;
    // 검색 데이터 수
    public long searchCount(String keyword) throws Exception;

    /* 마이페이지 */
    // 좋아요한 앨범 3개
    public List<Album> likedAlbumsTop3(@Param("id") Long id) throws Exception;
    // 좋아요한 앨범 전체
    public List<Album> likedAlbums(@Param("id") Long id, @Param("keyword") String keyword) throws Exception;

    // 전체 앨범 데이터 불러오기
    public List<Album> getAllAlbums(Pagination pagination) throws Exception;
}


