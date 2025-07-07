package com.cosmus.resonos.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.Track;
// import com.cosmus.resonos.external.SpotifyApiClient;
import com.cosmus.resonos.mapper.TrackMapper;

@Service
public class TrackServiceImpl implements TrackService {

    @Autowired
    private TrackMapper trackMapper;

    // 트랙 목록 조회
    @Override
    public List<Track> list() throws Exception {
        return trackMapper.list();
    }

    // 메인 화면 최신 트랙 목록 조회
    @Override
    public List<Track> mainNewList() throws Exception {
        return trackMapper.mainNewList();
    }
    
    @Override
    public List<Track> newList(Pagination pagination) throws Exception {
        long total = trackMapper.count();
        pagination.setTotal(total);
        return trackMapper.newList(pagination);
    }

    // 트랙 단건 조회
    @Override
    public Track selectById(String id) throws Exception {
        return trackMapper.selectById(id);
    }

    // 트랙 등록
    @Override
    public boolean insert(Track track) throws Exception {
        return trackMapper.insert(track) > 0;
    }

    // 트랙 수정
    @Override
    public boolean update(Track track) throws Exception {
        return trackMapper.update(track) > 0;
    }

    // 트랙 삭제
    @Override
    public boolean delete(String id) throws Exception {
        return trackMapper.delete(id) > 0;
    }

    // 트랙 존재 여부 확인
    @Override
    public boolean exists(String id) throws Exception {
        return trackMapper.exists(id) > 0;
    }

    // 구현 예정

    // // 스포티파이 동기화 서비스
    // @Autowired
    // private SpotifyApiClient spotifyApiClient;

    // public void syncTrackFromSpotify(String spotifyTrackId) throws Exception {
    //     String token = spotifyApiClient.getAccessToken();
    //     Map<String, Object> trackData = spotifyApiClient.getTrack(spotifyTrackId, token);

    //     // 1.2.1. trackData → Track 도메인 변환
    //     Track track = new Track();
    //     track.setId((String) trackData.get("id"));
    //     track.setTitle((String) trackData.get("name"));
    //     // ... 기타 필드 매핑

    //     // 1.2.2. 이미 존재하면 update, 없으면 insert
    //     if (this.exists(track.getId())) {
    //         this.update(track);
    //     } else {
    //         this.insert(track);
    //     }
    // }

    @Override
    public List<Track> selectTop7TracksByArtist(String id) throws Exception {
        return trackMapper.selectTop7TracksByArtist(id);
    }

    @Override
    public int countTracksByArtist(String id) throws Exception {
        return trackMapper.countTracksByArtist(id);
    }

    @Override
    public void syncTrackFromSpotify(String spotifyTrackId) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'syncTrackFromSpotify'");
    }
    @Override
    public List<Track> findTop5TracksInSameAlbum(String id) throws Exception {
        return trackMapper.findTop5TracksInSameAlbum(id);
    }

    @Override
    public String findArtistNameByTrackId(String id) throws Exception {
        return trackMapper.findArtistNameByTrackId(id);
    }

    @Override
    public List<Track> findTracksByAlbumId(String id) throws Exception {
        return trackMapper.findTracksByAlbumId(id);
    }

    @Override
    public List<Track> findTop5TracksByAlbumId(String id) throws Exception {
        return trackMapper.findTop5TracksByAlbumId(id);
    }

    @Override
    public Track findTopTrackByAlbumId(String id) throws Exception {
        return trackMapper.findTopTrackByAlbumId(id);

    }
    public List<Track> searchList(String keyword) throws Exception {
        return trackMapper.searchList(keyword);
    }

    @Override
    public List<Track> allSearchList(Map<String, Object> paramMap) throws Exception {
        String keyword = (String) paramMap.get("keyword");
        Pagination pagination = (Pagination) paramMap.get("pagination");
        long total = trackMapper.searchCount(keyword);
        if (pagination != null) {
            pagination.setTotal(total);
        }
        Map<String, Object> queryMap = new HashMap<>();
        queryMap.put("keyword", keyword);
        queryMap.put("index", pagination.getIndex());
        queryMap.put("size", pagination.getSize());
        return trackMapper.allSearchList(queryMap);
    }

}
