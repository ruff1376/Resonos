package com.cosmus.resonos.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.Track;

@Mapper
public interface TrackMapper {
    // 목록
    public List<Track> list() throws Exception;
    // 메인 화면 최신 트랙 목록
    public List<Track> mainNewList() throws Exception;
    // 최신 트랙 목록
    public List<Track> newList(Pagination pagination) throws Exception;
    // 메인 화면 인기 트랙 목록
    public List<Album> mainHotList() throws Exception;
    // 인기 트랙 목록
    public List<Album> hotList(Pagination pagination) throws Exception;
    // 데이터 수
    public long count() throws Exception;
    // 최신 데이터 수
    public long newCount() throws Exception;
    // 인기 데이터 수
    public long hotCount() throws Exception;
    // 조회
    public Track selectById(String id) throws Exception;
    // 삽입
    public int insert(Track track) throws Exception;
    // 수정
    public int update(Track track) throws Exception;
    // 삭제
    public int delete(String id) throws Exception;
    // 존재 여부 확인
    public int exists(String id) throws Exception;
    // 아티스트별 상위7개 인기곡
    public List<Track> selectTop7TracksByArtist(String id) throws Exception;
    // 아티스트별 곡 갯수
    public int countTracksByArtist(String id) throws Exception;
    // 트랙아이디로 같은앨범 상위5곡
    public List<Track> findTop5TracksInSameAlbum(String id) throws Exception;
    // 트랙아이디로 아티스트이름
    public String findArtistNameByTrackId(String id) throws Exception;
    // 앨범아이디로 앨범의 모든트랙
    public List<Track> findTracksByAlbumId(String id) throws Exception;
    // 앨범아이디로 앨범의 탑5트랙
    public List<Track> findTop5TracksByAlbumId(String id) throws Exception;
    // 앨범아이디로 앨범의 탑1트랙
    public Track findTopTrackByAlbumId(String id) throws Exception;
    // 검색 결과 목록
    public List<Track> searchList(String keyword) throws Exception;
    // 검색 결과 전체 목록
    public List<Track> allSearchList(Map<String, Object> paramMap) throws Exception;
    // 검색 데이터 수
    public long searchCount(String keyword) throws Exception;
    // 플레이리스트에 추가할 트랙 목록 검색
    public List<Track> addTrackList(@Param("keyword") String keyword) throws Exception;

}
