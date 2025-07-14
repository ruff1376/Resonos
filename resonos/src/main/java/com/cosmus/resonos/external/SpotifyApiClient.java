package com.cosmus.resonos.external;

import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.domain.Track;

@Component
public class SpotifyApiClient {

    @Value("${spotify.client-id}")
    private String clientId;
    @Value("${spotify.client-secret}")
    private String clientSecret;

    private final WebClient webClient = WebClient.create("https://api.spotify.com/v1");

    // 1. 토큰 발급 (실제 구현 필요)
    /**
     * OAuth2 Client Credentials Flow를 사용하여 Spotify API에 접근하기 위한 액세스 토큰을 발급받습니다.
     * 실제 구현은 Spotify API 문서를 참고하여 작성해야 합니다.
     *
     * @return 액세스 토큰
     */
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


    // 2. 아티스트 검색
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

    // 3. 앨범 검색
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

    // 4. 트랙(곡) 검색
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

    // 5. 아티스트 상세 정보
    public Map<String, Object> getArtist(String artistId, String accessToken) {
        return webClient.get()
                .uri("/artists/" + artistId)
                .header("Authorization", accessToken)
                .retrieve()
                .bodyToMono(Map.class)
                .block();
    }

    // 6. 앨범 상세 정보
    public Map<String, Object> getAlbum(String albumId, String accessToken) {
        return webClient.get()
                .uri("/albums/" + albumId)
                .header("Authorization", accessToken)
                .retrieve()
                .bodyToMono(Map.class)
                .block();
    }

    // 7. 트랙 상세 정보
    public Map<String, Object> getTrack(String trackId, String accessToken) {
        return webClient.get()
                .uri("/tracks/" + trackId)
                .header("Authorization", accessToken)
                .retrieve()
                .bodyToMono(Map.class)
                .block();
    }
    // 8. 아티스트의 앨범 목록 (album, single만 반환)
    public List<Map<String, Object>> getAlbumsByArtist(String artistId, String accessToken) {
        Map<String, Object> result = webClient.get()
                .uri(uriBuilder -> uriBuilder
                    .path("/artists/" + artistId + "/albums")
                    .queryParam("include_groups", "album,single") // album, single만 포함
                    .queryParam("limit", 50) // 필요시 페이지네이션 구현
                    .build())
                .header("Authorization", accessToken)
                .retrieve()
                .bodyToMono(Map.class)
                .block();

        if (result == null || !result.containsKey("items")) return Collections.emptyList();
        return (List<Map<String, Object>>) result.get("items");
    }


    // 9. 앨범의 트랙 목록
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

    // 10. 아티스트의 모든 트랙(앨범별로 모아서 반환)
    public List<Map<String, Object>> getTracksByArtist(String artistId, String accessToken) {
        List<Map<String, Object>> albums = getAlbumsByArtist(artistId, accessToken);
        List<Map<String, Object>> allTracks = new ArrayList<>();
        for (Map<String, Object> album : albums) {
            String albumId = (String) album.get("id");
            allTracks.addAll(getTracksByAlbum(albumId, accessToken));
        }
        return allTracks;
    }


  
}
