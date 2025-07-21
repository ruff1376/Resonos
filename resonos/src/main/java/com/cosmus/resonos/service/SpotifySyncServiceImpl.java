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
        if (artistId == null || artistMapper.exists(artistId) > 0) return;

        Artist artist = new Artist();
        artist.setId(artistId);
        artist.setName((String) artistData.get("name"));
        // profile_image
        if (artistData.get("images") instanceof List) {
            List<?> images = (List<?>) artistData.get("images");
            artist.setProfileImage(!images.isEmpty()
                ? (String) ((Map<?, ?>) images.get(0)).get("url")
                : null);
        }
        // genres
        if (artistData.get("genres") instanceof List) {
            List<?> genres = (List<?>) artistData.get("genres");
            artist.setGenres(!genres.isEmpty()
                ? String.join(",", genres.stream().map(Object::toString).toArray(String[]::new))
                : null);
        } else {
            artist.setGenres(null);
        }
        artistMapper.insert(artist);
    }

    @Override
    public void saveAlbumIfNotExists(Map<String, Object> albumData, String artistId) throws Exception {
        String albumId = (String) albumData.get("id");
        if (albumId == null || albumMapper.exists(albumId) > 0) return;

        Album album = new Album();
        album.setId(albumId);
        album.setTitle((String) albumData.get("name"));
        // cover_image
        if (albumData.get("images") instanceof List) {
            List<?> images = (List<?>) albumData.get("images");
            album.setCoverImage(!images.isEmpty()
                ? (String) ((Map<?, ?>) images.get(0)).get("url")
                : null);
        }
        // releaseDate (String → java.sql.Date로 파싱)
        Object releaseDateObj = albumData.get("release_date");
        if (releaseDateObj instanceof String) {
            String rawDate = (String) releaseDateObj;
            album.setReleaseDate(parseSpotifyDateToSqlDate(rawDate));
        }
        // genre (Spotify album 상세에는 거의 없음)
        String genre = (albumData.get("genres") instanceof List && !((List<?>) albumData.get("genres")).isEmpty())
            ? String.join(",", ((List<?>) albumData.get("genres")).stream().map(Object::toString).toArray(String[]::new))
            : null;
        album.setGenre(genre);
        album.setLabel((String) albumData.getOrDefault("label", null));
        // Spotify album 상세에는 description 거의 없음 (없으면 null)
        album.setDescription((String) albumData.getOrDefault("description", null));
        album.setArtistId(artistId);
        // country (available_markets, 있으면 첫번째)
        if (albumData.get("available_markets") instanceof List) {
            List<?> markets = (List<?>) albumData.get("available_markets");
            album.setCountry(!markets.isEmpty() ? markets.get(0).toString() : null);
        }
        albumMapper.insert(album);
    }

    @Override
    public void saveTrackIfNotExists(Map<String, Object> trackData, String albumId, String artistId) throws Exception {
        String trackId = (String) trackData.get("id");
        if (trackId == null || trackMapper.exists(trackId) > 0) return;

        Track track = new Track();
        track.setId(trackId);
        track.setTitle((String) trackData.get("name"));
        // duration
        track.setDuration(trackData.get("duration_ms") != null ? ((Number) trackData.get("duration_ms")).intValue() / 1000 : 0);
        // genre (없음, 필요시 trackData.get("genres") 등 활용 가능)
        track.setGenre((trackData.get("genres") instanceof List && !((List<?>) trackData.get("genres")).isEmpty())
            ? String.join(",", ((List<?>) trackData.get("genres")).stream().map(Object::toString).toArray(String[]::new))
            : null
        );
        // streaming_url
        if (trackData.get("external_urls") instanceof Map) {
            Map<?,?> externalUrls = (Map<?,?>) trackData.get("external_urls");
            track.setStreamingUrl((String) externalUrls.getOrDefault("spotify", null));
        } else {
            track.setStreamingUrl(null);
        }
        // mv_url (없음. 연동시 확장)
        track.setMvUrl((String) trackData.getOrDefault("mv_url", null));
        track.setAlbumId(albumId);
        track.setArtistId(artistId);
        // popularity
        track.setPopularity(trackData.get("popularity") != null ? ((Number) trackData.get("popularity")).intValue() : 0);
        // track_no
        track.setTrackNo(trackData.get("track_number") != null ? ((Number) trackData.get("track_number")).intValue() : 0);
        trackMapper.insert(track);
    }

    @Override
    public void syncArtistAndAlbumsAndTracks(String spotifyArtistId, String accessToken) throws Exception {
        // 1. 아티스트 가져오기(상세)
        Map<String, Object> artistData = spotifyApiClient.getArtist(spotifyArtistId, accessToken);
        if (artistData == null || artistData.get("id") == null) {
            throw new IllegalArgumentException("Spotify에서 아티스트 정보를 가져오지 못했습니다.");
        }
        saveArtistIfNotExists(artistData);

        // 2. 앨범 목록 → 앨범별 상세정보로 필드 merge
        List<Map<String, Object>> albums = spotifyApiClient.getAlbumsByArtist(spotifyArtistId, accessToken);
        for (Map<String, Object> albumStub : albums) {
            try {
                String albumId = (String) albumStub.get("id");
                if (albumId == null) continue;

                // -- 딜레이 (앨범 상세 요청 전) --
                safeSleep(200); // 200ms 대기

                Map<String, Object> albumDetail = spotifyApiClient.getAlbum(albumId, accessToken);
                // 상세값 merge (상세필드 우선) - 기본+상세 별도로 들어오니 putAll
                if (albumDetail != null) albumStub.putAll(albumDetail);
                saveAlbumIfNotExists(albumStub, spotifyArtistId);

                // 3. 해당 앨범의 트랙 목록 → 트랙별 상세정보로 popularity 등 보완
                List<Map<String, Object>> tracks = spotifyApiClient.getTracksByAlbum(albumId, accessToken);
                for (Map<String, Object> trackStub : tracks) {
                    try {
                        String trackId = (String) trackStub.get("id");
                        if (trackId == null) continue;

                        // -- 딜레이 (트랙 상세 요청 전) --
                        safeSleep(200); // 200ms 대기

                        Map<String, Object> trackDetail = spotifyApiClient.getTrack(trackId, accessToken);
                        if (trackDetail != null) trackStub.putAll(trackDetail);
                        saveTrackIfNotExists(trackStub, albumId, spotifyArtistId);
                    } catch (Exception trackEx) {
                        System.err.println("트랙 저장 오류: " + trackEx.getMessage());
                    }
                }
            } catch (Exception albumEx) {
                System.err.println("앨범 저장 오류: " + albumEx.getMessage());
            }
        }
    }

    // 안전한 Thread.sleep 헬퍼
    private static void safeSleep(long millis) {
        try { Thread.sleep(millis); } catch (InterruptedException ignore) {}
    }
    
    /** Spotify release_date(String) → java.sql.Date 변환 유틸 */
    private static java.sql.Date parseSpotifyDateToSqlDate(String dateStr) {
        if (dateStr == null) return null;
        String[] patterns = {"yyyy-MM-dd", "yyyy-MM", "yyyy"};
        for (String pattern : patterns) {
            try {
                java.util.Date utilDate = new java.text.SimpleDateFormat(pattern).parse(dateStr);
                return new java.sql.Date(utilDate.getTime());
            } catch (Exception ignore) {}
        }
        return null;
    }
}
