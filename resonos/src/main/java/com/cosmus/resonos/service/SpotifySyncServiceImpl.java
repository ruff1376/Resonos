package com.cosmus.resonos.service;

import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.mapper.ArtistMapper;
import com.cosmus.resonos.mapper.AlbumMapper;
import com.cosmus.resonos.mapper.TrackMapper;
import com.cosmus.resonos.external.SpotifyApiClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
@Service
public class SpotifySyncServiceImpl implements SpotifySyncService {

    @Autowired private SpotifyApiClient spotifyApiClient;
    @Autowired private ArtistMapper artistMapper;
    @Autowired private AlbumMapper albumMapper;
    @Autowired private TrackMapper trackMapper;

    @Override
    public void saveArtistIfNotExists(Map<String, Object> artistData) throws Exception {
        String artistId = (String) artistData.get("id");
        if (artistMapper.exists(artistId) == 0) {
            Artist artist = new Artist();
            artist.setId(artistId);
            artist.setName((String) artistData.get("name"));
            artist.setProfileImage(
                artistData.get("images") instanceof List && !((List<?>) artistData.get("images")).isEmpty()
                    ? (String)((Map<?, ?>)((List<?>) artistData.get("images")).get(0)).get("url") : null
            );
            artist.setGenres(String.join(",", (List<String>) artistData.getOrDefault("genres", new ArrayList<>())));
            artistMapper.insert(artist);
        }
    }

    @Override
    public void saveAlbumIfNotExists(Map<String, Object> albumData, String artistId) throws Exception {
        String albumId = (String) albumData.get("id");
        if (albumMapper.exists(albumId) == 0) {
            Album album = new Album();
            album.setId(albumId);
            album.setTitle((String) albumData.get("name"));
            album.setCoverImage(
                albumData.get("images") instanceof List && !((List<?>) albumData.get("images")).isEmpty()
                    ? (String)((Map<?, ?>)((List<?>) albumData.get("images")).get(0)).get("url") : null
            );
            // releaseDate 파싱 필요 (Spotify는 String, DB는 Date)
            Object releaseDateObj = albumData.get("release_date");
            if (releaseDateObj instanceof String) {
                // 예: "2024-01-01" → java.sql.Date.valueOf(...)
                album.setReleaseDate(java.sql.Date.valueOf((String) releaseDateObj));
            }
            album.setGenre(""); // 필요시
            album.setLabel((String) albumData.getOrDefault("label", ""));
            album.setDescription(""); // 필요시
            album.setArtistId(artistId);
            albumMapper.insert(album);
        }
    }

    @Override
    public void saveTrackIfNotExists(Map<String, Object> trackData, String albumId, String artistId) throws Exception {
        String trackId = (String) trackData.get("id");
        if (trackMapper.exists(trackId) == 0) {
            Track track = new Track();
            track.setId(trackId);
            track.setTitle((String) trackData.get("name"));
            track.setDuration(trackData.get("duration_ms") != null ? ((Number) trackData.get("duration_ms")).intValue() / 1000 : 0);
            track.setGenre(""); // 필요시
            track.setStreamingUrl((String) trackData.getOrDefault("preview_url", null));
            track.setAlbumId(albumId);
            track.setArtistId(artistId);
            track.setPopularity(trackData.get("popularity") != null ? ((Number) trackData.get("popularity")).intValue() : 0);
            track.setTrackNo(trackData.get("track_number") != null ? ((Number) trackData.get("track_number")).intValue() : 0);
            trackMapper.insert(track);
        }
    }

    // Spotify 아티스트, 앨범, 트랙 동기화
    // 1. 아티스트 ID로 아티스트 정보 가져오기
    
    @Override
    public void syncArtistAndAlbumsAndTracks(String spotifyArtistId, String accessToken) throws Exception {
        try {
            Map<String, Object> artistData = spotifyApiClient.getArtist(spotifyArtistId, accessToken);
            if (artistData == null || artistData.get("id") == null) {
                throw new IllegalArgumentException("Spotify에서 아티스트 정보를 가져오지 못했습니다.");
            }
            saveArtistIfNotExists(artistData);

            List<Map<String, Object>> albums = spotifyApiClient.getAlbumsByArtist(spotifyArtistId, accessToken);
            for (Map<String, Object> albumData : albums) {
                try {
                    String albumId = (String) albumData.get("id");
                    if (albumId == null) continue;
                    saveAlbumIfNotExists(albumData, spotifyArtistId);

                    List<Map<String, Object>> tracks = spotifyApiClient.getTracksByAlbum(albumId, accessToken);
                    for (Map<String, Object> trackData : tracks) {
                        try {
                            saveTrackIfNotExists(trackData, albumId, spotifyArtistId);
                        } catch (Exception trackEx) {
                            // 트랙 저장 중 오류 로그
                            System.err.println("트랙 저장 오류: " + trackEx.getMessage());
                        }
                    }
                } catch (Exception albumEx) {
                    // 앨범 저장 중 오류 로그
                    System.err.println("앨범 저장 오류: " + albumEx.getMessage());
                }
            }
        } catch (Exception e) {
            // 전체 동기화 실패 로그
            System.err.println("아티스트 동기화 오류: " + e.getMessage());
            throw e;
        }
    }

}
