package com.cosmus.resonos.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.external.SpotifyApiClient;
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
        long total = trackMapper.newCount();
        pagination.setTotal(total);
        return trackMapper.newList(pagination);
    }

    @Override
    public long count() throws Exception {
        return trackMapper.count();
    }

    @Override
    public long newCount() throws Exception {
        return trackMapper.newCount();
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


    @Override
    public List<Track> selectTop7TracksByArtist(String id) throws Exception {
        return trackMapper.selectTop7TracksByArtist(id);
    }

    @Override
    public int countTracksByArtist(String id) throws Exception {
        return trackMapper.countTracksByArtist(id);
    }

        @Autowired
    private SpotifyApiClient spotifyApiClient;

    @Override
    public void syncTrackFromSpotify(String spotifyTrackId) throws Exception {
        // 1. Spotify API에서 트랙 정보 가져오기
        String accessToken = spotifyApiClient.getAccessToken();
        Map<String, Object> trackData = spotifyApiClient.getTrack(spotifyTrackId, accessToken);

        if (trackData == null || trackData.get("id") == null) {
            throw new IllegalArgumentException("Spotify에서 트랙 정보를 가져오지 못했습니다.");
        }

        // 2. 트랙 도메인 객체로 매핑
        Track track = new Track();
        track.setId((String) trackData.get("id"));
        track.setTitle((String) trackData.get("name"));
        track.setDuration(trackData.get("duration_ms") != null ? ((Number) trackData.get("duration_ms")).intValue() / 1000 : 0);
        track.setGenre(""); // 필요시
        track.setStreamingUrl((String) trackData.getOrDefault("preview_url", null));
        // 앨범 ID
        if (trackData.get("album") instanceof Map) {
            Map<?, ?> album = (Map<?, ?>)trackData.get("album");
            track.setAlbumId((String)album.get("id"));
        }
        // 아티스트 ID
        if (trackData.get("artists") instanceof java.util.List && !((java.util.List<?>)trackData.get("artists")).isEmpty()) {
            java.util.Map<?, ?> firstArtist = (java.util.Map<?, ?>)((java.util.List<?>)trackData.get("artists")).get(0);
            track.setArtistId((String)firstArtist.get("id"));
        }
        track.setPopularity(trackData.get("popularity") != null ? ((Number) trackData.get("popularity")).intValue() : 0);
        track.setTrackNo(trackData.get("track_number") != null ? ((Number) trackData.get("track_number")).intValue() : 0);

        // 3. DB 저장 (존재하면 update, 없으면 insert)
        if (trackMapper.exists(track.getId()) == 0) {
            trackMapper.insert(track);
        } else {
            trackMapper.update(track);
        }
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
    public List<Track> allSearchList(String keyword, Pagination pagination, String sort) throws Exception {
        long total = trackMapper.searchCount(keyword);
        pagination.setTotal(total);
        return trackMapper.allSearchList(keyword, pagination, sort);
    }

    @Override
    public List<Track> addTrackList(String keyword) throws Exception {
        return trackMapper.addTrackList(keyword);
    }

    @Override
    public long searchCount(String keyword) throws Exception {
        return trackMapper.searchCount(keyword);
    }

    @Override
    public List<Track> mainHotList() throws Exception {
        return trackMapper.mainHotList();
    }

    @Override
    public List<Track> hotList(Pagination pagination) throws Exception {
        long total = trackMapper.hotCount();
        pagination.setTotal(total);
        return trackMapper.hotList(pagination);
    }

    @Override
    public long hotCount() throws Exception {
        return trackMapper.hotCount();
    }

    @Override
    public List<Track> likedTracksTop3(Long id) throws Exception {
        return trackMapper.likedTracksTop3(id);
    }

    @Override
    public List<Track> likedTracks(Long id, String keyword) throws Exception {
        return trackMapper.likedTracks(id, keyword);
    }

    // 페이징 전체 데이터
    @Override
    public List<Track> getAllTracks(Pagination pagination) throws Exception {
        return trackMapper.getAllTracks(pagination);
    }


}
