package com.cosmus.resonos.external;

import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.beans.factory.annotation.Value;

import java.util.*;

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
        // TODO: 실제 구현 (OAuth2 Client Credentials Flow)
        // 예시로 임시 토큰 반환
        // 실제로는 클라이언트 ID와 시크릿을 사용하여 토큰을 발급받아야 합니다.
        // 예시: https://accounts.spotify.com/api/token
        return "Bearer ...";
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

    // 8. 아티스트의 앨범 목록
    public List<Map<String, Object>> getAlbumsByArtist(String artistId, String accessToken) {
        Map<String, Object> result = webClient.get()
                .uri("/artists/" + artistId + "/albums")
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
