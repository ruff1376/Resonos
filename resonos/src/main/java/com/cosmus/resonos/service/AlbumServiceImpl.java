package com.cosmus.resonos.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.external.SpotifyApiClient;
import com.cosmus.resonos.mapper.AlbumMapper;

@Service
public class AlbumServiceImpl implements AlbumService {

    @Autowired
    private AlbumMapper albumMapper;

    // 앨범 목록 조회
    @Override
    public List<Album> list() throws Exception {
        return albumMapper.list();
    }

    // 메인 회면 최신 앨범 목록
    @Override
    public List<Album> mainNewList() throws Exception {
        return albumMapper.mainNewList();
    }

    // 최신 앨범 목록 조회
    @Override
    public List<Album> newList(Pagination pagination) throws Exception {
        long total = albumMapper.newCount();
        pagination.setTotal(total);
        return albumMapper.newList(pagination);
    }

    // 데이터 수
    @Override
    public long count() throws Exception {
        return albumMapper.count();
    }

    @Override
    public long newCount() throws Exception {
        return albumMapper.newCount();
    }

    // 앨범 단건 조회
    @Override
    public Album select(String id) throws Exception {
        return albumMapper.select(id);
    }

    // 앨범 등록
    @Override
    public boolean insert(Album album) throws Exception {
        return albumMapper.insert(album) > 0;
    }

    // 앨범 수정
    @Override
    public boolean update(Album album) throws Exception {
        return albumMapper.update(album) > 0;
    }

    // 앨범 삭제
    @Override
    public boolean delete(String id) throws Exception {
        return albumMapper.delete(id) > 0;
    }

    // 앨범 존재 여부 확인
    @Override
    public boolean exists(String id) throws Exception {
        return albumMapper.exists(id) > 0;
    }

    @Override
    public List<Album> findAlbumsByArtistId(String id) throws Exception {
        return albumMapper.findAlbumsByArtistId(id);
    }

    @Override
    public int countAlbumsByArtist(String id) throws Exception {
        return albumMapper.countAlbumsByArtist(id);
    }

    @Override
    public Album findAlbumByTrackId(String id) throws Exception {
        return albumMapper.findAlbumByTrackId(id);
    }

    @Override
    public List<Album> searchList(String keyword) throws Exception {
        return albumMapper.searchList(keyword);
    }

    @Override
    public List<Album> allSearchList(Map<String, Object> paramMap) throws Exception {
        String keyword = (String) paramMap.get("keyword");
        Pagination pagination = (Pagination) paramMap.get("pagination");
        long total = albumMapper.searchCount(keyword);
        if (pagination != null) {
            pagination.setTotal(total);
        }
        Map<String, Object> queryMap = new HashMap<>();
        queryMap.put("keyword", keyword);
        queryMap.put("index", pagination.getIndex());
        queryMap.put("size", pagination.getSize());
        return albumMapper.allSearchList(queryMap);
    }

    @Override
    public long searchCount(String keyword) throws Exception {
        return albumMapper.searchCount(keyword);
    }

    @Override
    public List<Album> mainHotList() throws Exception {
        return albumMapper.mainHotList();
    }

    @Override
    public List<Album> hotList(Pagination pagination) throws Exception {
        long total = albumMapper.hotCount();
        pagination.setTotal(total);
        return albumMapper.hotList(pagination);
    }

    @Override
    public long hotCount() throws Exception {
        return albumMapper.hotCount();
    }

    @Override
    public List<Album> likedAlbumsTop3(Long id) throws Exception {
        return albumMapper.likedAlbumsTop3(id);
    }


    @Override
    public List<Album> likedAlbums(Long id) throws Exception {
        return albumMapper.likedAlbums(id);
    }

    @Override
    public List<Album> korHotReviewList() throws Exception {
        return albumMapper.korHotReviewList();
    }

    @Override
    public List<Album> worldHotReviewList() throws Exception {
        return albumMapper.worldHotReviewList();
    }

    // spotify 앨범 저장 
    @Autowired
    private SpotifyApiClient spotifyApiClient;

    @Override
    public void syncAlbumFromSpotify(String spotifyAlbumId) throws Exception {
        // 1. Spotify API에서 앨범 정보 가져오기
        String accessToken = spotifyApiClient.getAccessToken();
        Map<String, Object> albumData = spotifyApiClient.getAlbum(spotifyAlbumId, accessToken);

        if (albumData == null || albumData.get("id") == null) {
            throw new IllegalArgumentException("Spotify에서 앨범 정보를 가져오지 못했습니다.");
        }

        // 2. 앨범 도메인 객체로 매핑
        Album album = new Album();
        album.setId((String) albumData.get("id"));
        album.setTitle((String) albumData.get("name"));
        album.setCoverImage(
            albumData.get("images") instanceof java.util.List && !((java.util.List<?>) albumData.get("images")).isEmpty()
                ? (String)((java.util.Map<?, ?>)((java.util.List<?>) albumData.get("images")).get(0)).get("url") : null
        );
        Object releaseDateObj = albumData.get("release_date");
        if (releaseDateObj instanceof String) {
            album.setReleaseDate(java.sql.Date.valueOf((String) releaseDateObj));
        }
        album.setGenre(""); // 필요시
        album.setLabel((String) albumData.getOrDefault("label", ""));
        album.setDescription(""); // 필요시
        // 아티스트 ID 추출
        if (albumData.get("artists") instanceof java.util.List && !((java.util.List<?>)albumData.get("artists")).isEmpty()) {
            java.util.Map<?, ?> firstArtist = (java.util.Map<?, ?>)((java.util.List<?>)albumData.get("artists")).get(0);
            album.setArtistId((String)firstArtist.get("id"));
        }
        // 3. DB 저장 (존재하면 update, 없으면 insert)
        if (albumMapper.exists(album.getId()) == 0) {
            albumMapper.insert(album);
        } else {
            albumMapper.update(album);
        }
    }

    // 전체 앨범 데이터 블러오기 
    @Override
    public List<Album> getAllAlbums(Pagination pagination) throws Exception {
        return albumMapper.getAllAlbums(pagination);
    }

}
