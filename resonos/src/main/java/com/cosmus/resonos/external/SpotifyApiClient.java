package com.cosmus.resonos.external;

import java.util.*;
import java.util.stream.Collectors;
import java.util.Base64;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;

import com.cosmus.resonos.domain.review.Album;
import com.cosmus.resonos.domain.review.Artist;
import com.cosmus.resonos.domain.review.Track;

@Component
public class SpotifyApiClient {

    // @Value("${spotify.client-id}")
    private String clientId;
    // @Value("${spotify.client-secret}")
    private String clientSecret;

    private final WebClient webClient = WebClient.create("https://api.spotify.com/v1");

    /** 1. 토큰 발급 */
    public String getAccessToken() {
        String tokenUrl = "https://accounts.spotify.com/api/token";
        String credentials = Base64.getEncoder().encodeToString((clientId + ":" + clientSecret).getBytes());
        Map<String, String> formData = Map.of("grant_type", "client_credentials");

        Map<String, Object> response = WebClient.create()
            .post()
            .uri(tokenUrl)
            .header("Authorization", "Basic " + credentials)
            .header("Content-Type", "application/x-www-form-urlencoded")
            .bodyValue(formData.entrySet().stream()
                .map(e -> e.getKey() + "=" + e.getValue())
                .collect(Collectors.joining("&")))
            .retrieve()
            .bodyToMono(Map.class)
            .block();

        return "Bearer " + response.get("access_token");
    }

    /** ---- 날짜 변환 ---- */
    public Date parseSpotifyDate(String dateStr) {
        if (dateStr == null) return null;
        String[] patterns = {"yyyy-MM-dd", "yyyy-MM", "yyyy"};
        for (String pattern : patterns) {
            try {
                return new SimpleDateFormat(pattern).parse(dateStr);
            } catch (ParseException ignored) {}
        }
        return null;
    }

    /** ---- 변환 메서드 ---- */
    public Artist toArtist(Map<String, Object> artistJson) {
        Artist artist = new Artist();
        artist.setId((String) artistJson.get("id"));
        artist.setName((String) artistJson.get("name"));
        // profile_image
        List<Map<String, Object>> images = (List<Map<String, Object>>) artistJson.get("images");
        artist.setProfileImage((images != null && !images.isEmpty()) ? (String) images.get(0).get("url") : null);
        // genres
        List<String> genres = (List<String>) artistJson.get("genres");
        artist.setGenres((genres != null && !genres.isEmpty()) ? String.join(",", genres) : null);
        return artist;
    }

    public Album toAlbum(Map<String, Object> albumJson) {
        Album album = new Album();
        album.setId((String) albumJson.get("id"));
        album.setTitle((String) albumJson.get("name"));
        // cover_image
        List<Map<String, Object>> images = (List<Map<String, Object>>) albumJson.get("images");
        album.setCoverImage((images != null && !images.isEmpty()) ? (String) images.get(0).get("url") : null);
        // release_date (String -> Date)
        album.setReleaseDate(parseSpotifyDate((String) albumJson.get("release_date")));
        // label
        album.setLabel((String) albumJson.get("label"));
        // description (없음)
        album.setDescription(null);
        // artist_id
        List<Map<String, Object>> artists = (List<Map<String, Object>>) albumJson.get("artists");
        album.setArtistId((artists != null && !artists.isEmpty()) ? (String) artists.get(0).get("id") : null);
        // country (available_markets)
        List<String> availableMarkets = (List<String>) albumJson.get("available_markets");
        album.setCountry((availableMarkets != null && !availableMarkets.isEmpty()) ? availableMarkets.get(0) : null);
        // genre (없음)
        album.setGenre(null);
        return album;
    }

    public Track toTrack(Map<String, Object> trackJson) {
        Track track = new Track();
        track.setId((String) trackJson.get("id"));
        track.setTitle((String) trackJson.get("name"));
        // duration
        Object durationMsObj = trackJson.get("duration_ms");
        int duration = 0;
        if (durationMsObj instanceof Integer) {
            duration = ((Integer) durationMsObj) / 1000;
        } else if (durationMsObj instanceof Long) {
            duration = (int) (((Long) durationMsObj) / 1000L);
        }
        track.setDuration(duration);
        // streaming_url
        Map<String, Object> externalUrls = (Map<String, Object>) trackJson.get("external_urls");
        track.setStreamingUrl(externalUrls != null ? (String) externalUrls.get("spotify") : null);
        track.setMvUrl(null); // 없음
        // album_id
        Map<String, Object> album = (Map<String, Object>) trackJson.get("album");
        track.setAlbumId(album != null ? (String) album.get("id") : null);
        // artist_id
        List<Map<String, Object>> artists = (List<Map<String, Object>>) trackJson.get("artists");
        track.setArtistId((artists != null && !artists.isEmpty()) ? (String) artists.get(0).get("id") : null);
        // popularity
        Object popularityObj = trackJson.get("popularity");
        track.setPopularity(popularityObj instanceof Integer ? (Integer) popularityObj : 0);
        // track_no
        Object trackNoObj = trackJson.get("track_number");
        track.setTrackNo(trackNoObj instanceof Integer ? (Integer) trackNoObj : 0);
        // genre (없음)
        track.setGenre(null);
        return track;
    }

    // ---- Map 기반 원본 함수들 ----

    /** 2. 아티스트 검색 (Map) */
    public List<Map<String, Object>> searchArtist(String query, String accessToken) {
        Map<String, Object> result = webClient.get()
                .uri(uriBuilder -> uriBuilder.path("/search")
                        .queryParam("q", query)
                        .queryParam("type", "artist")
                        .build())
                .header("Authorization", accessToken)
                .retrieve()
                .bodyToMono(Map.class)
                .block();

        if (result == null || !result.containsKey("artists")) return Collections.emptyList();
        Map<String, Object> artists = (Map<String, Object>) result.get("artists");
        return (List<Map<String, Object>>) artists.get("items");
    }

    /** 3. 앨범 검색 (Map) */
    public List<Map<String, Object>> searchAlbum(String query, String accessToken) {
        Map<String, Object> result = webClient.get()
                .uri(uriBuilder -> uriBuilder.path("/search")
                        .queryParam("q", query)
                        .queryParam("type", "album")
                        .build())
                .header("Authorization", accessToken)
                .retrieve()
                .bodyToMono(Map.class)
                .block();

        if (result == null || !result.containsKey("albums")) return Collections.emptyList();
        Map<String, Object> albums = (Map<String, Object>) result.get("albums");
        return (List<Map<String, Object>>) albums.get("items");
    }

    /** 4. 트랙 검색 (Map) */
    public List<Map<String, Object>> searchTrack(String query, String accessToken) {
        Map<String, Object> result = webClient.get()
                .uri(uriBuilder -> uriBuilder.path("/search")
                        .queryParam("q", query)
                        .queryParam("type", "track")
                        .build())
                .header("Authorization", accessToken)
                .retrieve()
                .bodyToMono(Map.class)
                .block();

        if (result == null || !result.containsKey("tracks")) return Collections.emptyList();
        Map<String, Object> tracks = (Map<String, Object>) result.get("tracks");
        return (List<Map<String, Object>>) tracks.get("items");
    }

    /** 5. 아티스트 상세정보 (Map) */
    public Map<String, Object> getArtist(String artistId, String accessToken) {
        return webClient.get()
                .uri("/artists/" + artistId)
                .header("Authorization", accessToken)
                .retrieve()
                .bodyToMono(Map.class)
                .block();
    }

    /** 6. 앨범 상세정보 (Map) */
    public Map<String, Object> getAlbum(String albumId, String accessToken) {
        return webClient.get()
                .uri("/albums/" + albumId)
                .header("Authorization", accessToken)
                .retrieve()
                .bodyToMono(Map.class)
                .block();
    }

    /** 7. 트랙 상세정보 (Map) */
    public Map<String, Object> getTrack(String trackId, String accessToken) {
        return webClient.get()
                .uri("/tracks/" + trackId)
                .header("Authorization", accessToken)
                .retrieve()
                .bodyToMono(Map.class)
                .block();
    }

    /** 8. 아티스트의 앨범 목록 (Map) */
    public List<Map<String, Object>> getAlbumsByArtist(String artistId, String accessToken) {
        Map<String, Object> result = webClient.get()
                .uri(uriBuilder -> uriBuilder
                    .path("/artists/" + artistId + "/albums")
                    .queryParam("include_groups", "album,single")
                    .queryParam("limit", 50)
                    .build())
                .header("Authorization", accessToken)
                .retrieve()
                .bodyToMono(Map.class)
                .block();
        if (result == null || !result.containsKey("items")) return Collections.emptyList();
        return (List<Map<String, Object>>) result.get("items");
    }

    /** 9. 앨범의 트랙 목록 (Map) */
    public List<Map<String, Object>> getTracksByAlbum(String albumId, String accessToken) {
        Map<String, Object> result = webClient.get()
                .uri("/albums/" + albumId + "/tracks")
                .header("Authorization", accessToken)
                .retrieve()
                .bodyToMono(Map.class)
                .block();
        if (result == null || !result.containsKey("items")) return Collections.emptyList();
        return (List<Map<String, Object>>) result.get("items");
    }

    /** 10. 아티스트의 모든 트랙(앨범별로 Map 반환) */
    public List<Map<String, Object>> getTracksByArtist(String artistId, String accessToken) {
        List<Map<String, Object>> albums = getAlbumsByArtist(artistId, accessToken);
        List<Map<String, Object>> allTracks = new ArrayList<>();
        for (Map<String, Object> album : albums) {
            String albumId = (String) album.get("id");
            allTracks.addAll(getTracksByAlbum(albumId, accessToken));
        }
        return allTracks;
    }

    // -------------------------------------------------------------
    // ---- 위의 Map 기반 함수의 DTO 버전 기능을 별도 제공 ----

    /** 2-1. 아티스트 검색 (DTO) */
    public List<Artist> searchArtistDto(String query, String accessToken) {
        List<Map<String, Object>> items = searchArtist(query, accessToken);
        return items.stream().map(this::toArtist).collect(Collectors.toList());
    }
    /** 3-1. 앨범 검색 (DTO) */
    public List<Album> searchAlbumDto(String query, String accessToken) {
        List<Map<String, Object>> items = searchAlbum(query, accessToken);
        return items.stream().map(this::toAlbum).collect(Collectors.toList());
    }
    /** 4-1. 트랙 검색 (DTO) */
    public List<Track> searchTrackDto(String query, String accessToken) {
        List<Map<String, Object>> items = searchTrack(query, accessToken);
        return items.stream().map(this::toTrack).collect(Collectors.toList());
    }

    /** 5-1. 아티스트 상세 (DTO) */
    public Artist getArtistDto(String artistId, String accessToken) {
        return toArtist(getArtist(artistId, accessToken));
    }
    /** 6-1. 앨범 상세 (DTO) */
    public Album getAlbumDto(String albumId, String accessToken) {
        return toAlbum(getAlbum(albumId, accessToken));
    }
    /** 7-1. 트랙 상세 (DTO) */
    public Track getTrackDto(String trackId, String accessToken) {
        return toTrack(getTrack(trackId, accessToken));
    }
    /** 8-1. 아티스트의 앨범 목록 (DTO) */
    public List<Album> getAlbumsByArtistDto(String artistId, String accessToken) {
        List<Map<String, Object>> items = getAlbumsByArtist(artistId, accessToken);
        return items.stream().map(this::toAlbum).collect(Collectors.toList());
    }
    /** 9-1. 앨범의 트랙 목록 (DTO) */
    public List<Track> getTracksByAlbumDto(String albumId, String accessToken) {
        List<Map<String, Object>> items = getTracksByAlbum(albumId, accessToken);
        return items.stream().map(this::toTrack).collect(Collectors.toList());
    }
    /** 10-1. 아티스트의 모든 트랙 (DTO) */
    public List<Track> getTracksByArtistDto(String artistId, String accessToken) {
        List<Album> albums = getAlbumsByArtistDto(artistId, accessToken);
        List<Track> allTracks = new ArrayList<>();
        for (Album album : albums) {
            if (album.getId() != null)
                allTracks.addAll(getTracksByAlbumDto(album.getId(), accessToken));
        }
        return allTracks;
    }

}
