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
            album.setReleaseDate(albumData.get("release_date") != null ? (String) albumData.get("release_date") : null);
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

    /**
     * 아티스트, 앨범, 트랙 전체 동기화 (아티스트 → 앨범 → 트랙)
     */
    @Override
    public void syncArtistAndAlbumsAndTracks(String spotifyArtistId, String accessToken) throws Exception {
        // 1. 아티스트
        Map<String, Object> artistData = spotifyApiClient.getArtist(spotifyArtistId, accessToken);
        saveArtistIfNotExists(artistData);

        // 2. 앨범
        List<Map<String, Object>> albums = spotifyApiClient.getAlbumsByArtist(spotifyArtistId, accessToken);
        for (Map<String, Object> albumData : albums) {
            String albumId = (String) albumData.get("id");
            saveAlbumIfNotExists(albumData, spotifyArtistId);

            // 3. 트랙
            List<Map<String, Object>> tracks = spotifyApiClient.getTracksByAlbum(albumId, accessToken);
            for (Map<String, Object> trackData : tracks) {
                saveTrackIfNotExists(trackData, albumId, spotifyArtistId);
            }
        }
    }
}
