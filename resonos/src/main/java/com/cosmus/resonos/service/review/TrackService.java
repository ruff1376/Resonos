package com.cosmus.resonos.service.review;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.Track.Track;
public interface TrackService {
    // 목록
    public List<Track> list() throws Exception;
    // 메인 화면 최신 트랙 목록
    public List<Track> mainNewList() throws Exception;
    // 최신 트랙 목록
    public List<Track> newList(Pagination pagination) throws Exception;
    // 메인 화면 인기 트랙 목록
    public List<Track> mainHotList() throws Exception;
    // 인기 트랙 목록
    public List<Track> hotList(Pagination pagination) throws Exception;
    // 데이터 수
    public long count() throws Exception;
    // 최신 데이터 수
    public long newCount() throws Exception;
    // 인기 데이터 수
    public long hotCount() throws Exception;
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

    // 동기화: Spotify에서 트랙 정보를 가져와서 데이터베이스에 저장
    public void syncTrackFromSpotify(String spotifyTrackId) throws Exception;
    // 아티스트별 상위7개 인기곡
    public List<Track> selectTop7TracksByArtist(String id) throws Exception;
    // 아티스트아이디당 트랙갯수
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
    public List<Track> searchList(@Param("keyword") String keyword) throws Exception;
    // 검색 결과 전체 목록
    public List<Track> allSearchList(
        @Param("keyword") String keyword,
        @Param("pagination") Pagination pagination,
        @Param("sort") String sort
    ) throws Exception;
    // 검색 데이터 수
    public long searchCount(String keyword) throws Exception;

    /* 마이페이지 */
    // 플레이리스트에 추가할 트랙 목록 검색
    public List<Track> addTrackList(String keyword, int offset, int limit) throws Exception;
    // 좋아요 한 트랙 3개 조회
    public List<Track> likedTracksTop3(Long id) throws Exception;
    // 좋아요 한 트랙 전체 조회
    public List<Track> likedTracks(Long id, String keyword, int offset, int limit) throws Exception;
    // 좋아요 한 트랙 수
    public int countLikedTracks(Long id) throws Exception;

    // 페이징 전체 데이터
    public List<Track> getAllTracks(Pagination pagination) throws Exception;

    // mvUrl 업데이트
    void updateMvUrl(@Param("id") String id, @Param("mvUrl") String mvUrl);
    // 조회후 mvUrl 업데이트
    public Track getTrackOrUpdate(String id) throws Exception;
    public Track topTrackByAlbumIdAndFetchMv(String id) throws Exception;
    public List<Track> selectTop7TracksByArtistAndFetchMv(String id) throws Exception;

    // 태그로 트랙 검색
    public List<Track> searchTracksByTag(@Param("tagName") String tagName) throws Exception;
}
