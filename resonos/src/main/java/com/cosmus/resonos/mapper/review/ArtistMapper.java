package com.cosmus.resonos.mapper.review;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.review.Artist;

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
    public List<Artist> listPaging(@Param("offset") int offset, @Param("size") int size);
    // 검색 결과 목록
    public List<Artist> searchList(String keyword) throws Exception;
    // 검색 결과 전체 목록
    public List<Artist> allSearchList(Map<String, Object> paramMap) throws Exception;
    // 검색 데이터 수
    public long searchCount(String keyword) throws Exception;
    // 전체 수
    public long count() throws Exception;
    // 앨범아이디로 아티스트객체
    public Artist findArtistByAlbumId(String id) throws Exception;

    /* 마이페이지 */
    // 팔로우 한 아티스트 3건 조회
    public List<Artist> followingArtistsTop3(@Param("id") Long id) throws Exception;
    // 팔로우 한 아티스트 전체 조회
    public List<Artist> followingArtists(@Param("id") Long id, @Param("keyword") String keyword, @Param("offset") int offset, @Param("limit") int limit) throws Exception;
    // 팔로우 한 아티스트 수 조회
    public int countFollowingArtists(@Param("id") Long id) throws Exception;
}
