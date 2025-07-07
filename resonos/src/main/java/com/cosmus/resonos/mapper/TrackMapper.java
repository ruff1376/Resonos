package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Track;

@Mapper
public interface TrackMapper {
    // 목록
    public List<Track> list() throws Exception;
    // 메인 회면 최신 앨범 목록
    public List<Track> mainNewList() throws Exception;
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
    // 검색 결과 목록
    public List<Track> searchList(String keyword) throws Exception;
    // 검색 결과 전체 목록
    public List<Track> allSearchList(String keyword) throws Exception;
}
