package com.cosmus.resonos.controller.admin;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.review.Album;
import com.cosmus.resonos.domain.review.Artist;
import com.cosmus.resonos.domain.review.Track;
import com.cosmus.resonos.external.SpotifyApiClient;
import com.cosmus.resonos.service.admin.SpotifySyncService;
import com.cosmus.resonos.service.review.AlbumService;
import com.cosmus.resonos.service.review.ArtistService;
import com.cosmus.resonos.service.review.TrackService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin("*")
@RestController
@RequestMapping("/admin/music")
public class AdminMusicController {

    @Autowired private TrackService trackService;
    @Autowired private AlbumService albumService;
    @Autowired private ArtistService artistService;
    @Autowired private SpotifyApiClient spotifyApiClient;
    @Autowired private SpotifySyncService spotifySyncService;

    /** 🎵 음악 목록 조회 (앨범/트랙/아티스트) */
    @GetMapping("")
    public Map<String, Object> getMusicData(
        @RequestParam(value = "tab", defaultValue = "track") String tab,
        @RequestParam(value = "page", defaultValue = "1") int page,
        @RequestParam(value = "size", defaultValue = "10") int size
    ) throws Exception{
        Map<String, Object> res = new HashMap<>();

        // Pagination 생성
        Pagination albumPagination = new Pagination("album".equals(tab) ? page : 1, size, 10, albumService.count());
        Pagination trackPagination = new Pagination("track".equals(tab) ? page : 1, size, 10, trackService.count());
        Pagination artistPagination = new Pagination("artist".equals(tab) ? page : 1, size, 10, artistService.count());

        res.put("albums", albumService.getAllAlbums(albumPagination));
        res.put("tracks", trackService.getAllTracks(trackPagination));
        res.put("artists", artistService.listPaging((int) artistPagination.getIndex(), (int) artistPagination.getSize()));

        if ("album".equals(tab)) {
            res.put("pagination", albumPagination);
        } else if ("artist".equals(tab)) {
            res.put("pagination", artistPagination);
        } else {
            res.put("pagination", trackPagination);
        }

        res.put("tab", tab);
        res.put("size", size);
        return res;
    }

    // ===== 트랙 CRUD =====

    @PostMapping("/track")
    public Map<String, Object> saveTrack(@RequestBody Track track) throws Exception {
        if (trackService.exists(track.getId())) {
            trackService.update(track);
        } else {
            trackService.insert(track);
        }
        return Map.of("success", true, "message", "트랙 저장 완료");
    }

    @DeleteMapping("/track/{id}")
    public Map<String, Object> deleteTrack(@PathVariable("id") String id) throws Exception {
        trackService.delete(id);
        return Map.of("success", true, "message", "트랙 삭제 완료");
    }

    // ===== 앨범 CRUD =====

    @PostMapping("/album")
    public Map<String, Object> saveAlbum(@RequestBody Album album) throws Exception {
        if (albumService.exists(album.getId())) {
            albumService.update(album);
        } else {
            albumService.insert(album);
        }
        return Map.of("success", true, "message", "앨범 저장 완료");
    }

    @DeleteMapping("/album/{id}")
    public Map<String, Object> deleteAlbum(@PathVariable("id") String id) throws Exception {
        albumService.delete(id);
        return Map.of("success", true, "message", "앨범 삭제 완료");
    }

    // ===== 아티스트 CRUD =====

    @PostMapping("/artist")
    public Map<String, Object> saveArtist(@RequestBody Artist artist) throws Exception {
        if (artistService.exists(artist.getId())) {
            artistService.update(artist);
        } else {
            artistService.insert(artist);
        }
        return Map.of("success", true, "message", "아티스트 저장 완료");
    }

    @DeleteMapping("/artist/{id}")
    public Map<String, Object> deleteArtist(@PathVariable("id") String id) throws Exception {
        artistService.delete(id);
        return Map.of("success", true, "message", "아티스트 삭제 완료");
    }

    // ===== Spotify 동기화 =====

    @PostMapping("/track/sync")
    public Map<String, Object> syncTrack(@RequestParam("spotifyTrackId") String spotifyTrackId) throws Exception {
        trackService.syncTrackFromSpotify(spotifyTrackId);
        return Map.of("success", true, "message", "트랙 동기화 완료!");
    }

    @PostMapping("/sync-artist")
    public Map<String, Object> syncArtistAjax(@RequestParam("spotifyArtistId") String spotifyArtistId) {
        Map<String, Object> result = new HashMap<>();
        try {
            String accessToken = spotifyApiClient.getAccessToken();
            String artistId = spotifyArtistId;

            // 이름인 경우 검색 후 id 추출
            if (artistId.length() != 22 || !artistId.matches("^[A-Za-z0-9]+$")) {
                List<Map<String, Object>> results = spotifyApiClient.searchArtist(artistId, accessToken);
                if (results.isEmpty()) {
                    return Map.of("success", false, "message", "Spotify에서 아티스트를 찾을 수 없음");
                }
                artistId = (String) results.get(0).get("id");
            }

            spotifySyncService.syncArtistAndAlbumsAndTracks(artistId, accessToken);
            result.put("success", true);
            result.put("message", "아티스트 및 관련 데이터 동기화 완료");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

 // spotify 아티스트 검색
    @GetMapping("/search-artist")
    public Map<String, Object> searchArtist(@RequestParam("query") String query) {
        Map<String, Object> result = new HashMap<>();
        try {
            String accessToken = spotifyApiClient.getAccessToken();
            List<Map<String, Object>> items = spotifyApiClient.searchArtist(query, accessToken);
            List<Map<String, Object>> artists = new ArrayList<>();
            for (Map<String, Object> item : items) {
                Map<String, Object> artist = new HashMap<>();
                artist.put("id", item.get("id"));
                artist.put("name", item.get("name"));
                artist.put("genres", item.get("genres") != null ? String.join(",", (List<String>) item.get("genres")) : "");
                if (item.get("images") instanceof List && !((List<?>) item.get("images")).isEmpty()) {
                    artist.put("image", ((Map<?, ?>)((List<?>) item.get("images")).get(0)).get("url"));
                } else {
                    artist.put("image", "");
                }
                artists.add(artist);
            }
            result.put("success", true);
            result.put("artists", artists);
        } catch (Exception e) {
            result.put("success", false);
            result.put("artists", Collections.emptyList());
            result.put("message", e.getMessage());
        }
        return result;
    }

    // spotify 앨범 검색
    @GetMapping("/search-album")
    public Map<String, Object> searchAlbum(@RequestParam("query") String query) {
        Map<String, Object> result = new HashMap<>();
        try {
            String accessToken = spotifyApiClient.getAccessToken();
            List<Map<String, Object>> items = spotifyApiClient.searchAlbum(query, accessToken);
            List<Map<String, Object>> albums = new ArrayList<>();
            for (Map<String, Object> item : items) {
                Map<String, Object> album = new HashMap<>();
                album.put("id", item.get("id"));
                album.put("title", item.get("name"));
                album.put("coverImage", ((List<Map<String, String>>) item.get("images")).get(0).get("url"));
                album.put("releaseDate", item.get("release_date"));
                album.put("genre", item.get("genres") != null ? String.join(",", (List<String>) item.get("genres")) : "");
                album.put("label", item.get("label"));
                album.put("description", item.get("description"));
                if (item.get("artists") instanceof List && !((List<?>) item.get("artists")).isEmpty()) {
                    Map<?, ?> firstArtist = (Map<?, ?>) ((List<?>) item.get("artists")).get(0);
                    album.put("artistId", firstArtist.get("id"));
                } else {
                    album.put("artistId", "");
                }
                albums.add(album);
            }
            result.put("success", true);
            result.put("albums", albums);
        } catch (Exception e) {
            result.put("success", false);
            result.put("albums", Collections.emptyList());
            result.put("message", e.getMessage());
        }
        return result;
    }

    // spotify 트랙 검색
    @GetMapping("/search-track")
    public Map<String, Object> searchTrack(@RequestParam("query") String query) {
        Map<String, Object> result = new HashMap<>();
        try {
            String accessToken = spotifyApiClient.getAccessToken();
            List<Map<String, Object>> items = spotifyApiClient.searchTrack(query, accessToken);
            List<Map<String, Object>> tracks = new ArrayList<>();
            for (Map<String, Object> item : items) {
                Map<String, Object> track = new HashMap<>();
                track.put("id", item.get("id"));
                track.put("title", item.get("name"));
                track.put("genre", item.get("genre") != null ? String.join(",", (List<String>) item.get("genre")) : "");
                if (item.get("album") instanceof Map) {
                    Map<?, ?> album = (Map<?, ?>) item.get("album");
                    track.put("albumId", album.get("id"));
                } else {
                    track.put("albumId", "");
                }
                if (item.get("artists") instanceof List && !((List<?>) item.get("artists")).isEmpty()) {
                    Map<?, ?> firstArtist = (Map<?, ?>) ((List<?>) item.get("artists")).get(0);
                    track.put("artistId", firstArtist.get("id"));
                } else {
                    track.put("artistId", "");
                }
                track.put("duration", item.get("duration_ms"));
                track.put("popularity", item.get("popularity"));
                track.put("trackNo", item.get("track_number"));
                tracks.add(track);
            }
            result.put("success", true);
            result.put("tracks", tracks);
        } catch (Exception e) {
            result.put("success", false);
            result.put("tracks", Collections.emptyList());
            result.put("message", e.getMessage());
        }
        return result;
    }

    @PostMapping("/sync-track")
    public Map<String, Object> syncTrackAjax(@RequestParam("spotifyTrackId") String spotifyTrackId) {
        Map<String, Object> result = new HashMap<>();
        try {
            trackService.syncTrackFromSpotify(spotifyTrackId);
            result.put("success", true);
            result.put("message", "트랙 동기화 성공!");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "트랙 동기화 실패: " + e.getMessage());
        }
        return result;
    }

    @PostMapping("/sync-album")
    public Map<String, Object> syncAlbumAjax(@RequestParam("spotifyAlbumId") String spotifyAlbumId) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 실제 동기화 서비스 호출
            result.put("success", true);
            result.put("message", "앨범 동기화 성공!");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "앨범 동기화 실패: " + e.getMessage());
        }
        return result;
    }

    // DB 아티스트 검색
    @GetMapping("/artist/list")
    public Map<String, Object> searchArtistList(@RequestParam(name = "keyword", defaultValue = "") String keyword) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Artist> items = artistService.searchList(keyword);
            List<Map<String, Object>> artists = new ArrayList<>();
            for (Artist item : items) {
                Map<String, Object> artist = new HashMap<>();
                artist.put("id", item.getId());
                artist.put("name", item.getName());
                artist.put("genres", item.getGenres());
                artist.put("image", item.getProfileImage());
                artists.add(artist);
            }
            result.put("success", true);
            result.put("artists", artists);
        } catch (Exception e) {
            result.put("success", false);
            result.put("artists", Collections.emptyList());
            result.put("message", e.getMessage());
        }
        return result;
    }

    // DB 앨범 검색
    @GetMapping("/album/list")
    public Map<String, Object> searchAlbumList(@RequestParam(name = "keyword", defaultValue = "") String keyword) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Album> items = albumService.searchList(keyword);
            List<Map<String, Object>> albums = new ArrayList<>();
            for (Album item : items) {
                Map<String, Object> album = new HashMap<>();
                album.put("id", item.getId());
                album.put("title", item.getTitle());
                album.put("coverImage", item.getCoverImage());
                album.put("releaseDate", item.getReleaseDate());
                album.put("genre", item.getGenre());
                album.put("label", item.getLabel());
                album.put("description", item.getDescription());
                album.put("artistId", item.getArtistId());
                albums.add(album);
            }
            result.put("success", true);
            result.put("albums", albums);
        } catch (Exception e) {
            result.put("success", false);
            result.put("albums", Collections.emptyList());
            result.put("message", e.getMessage());
        }
        return result;
    }

    // DB 트랙 검색
    @GetMapping("/track/list")
    public Map<String, Object> searchTrackList(@RequestParam(name = "keyword", defaultValue = "") String keyword) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Track> items = trackService.searchList(keyword);
            List<Map<String, Object>> tracks = new ArrayList<>();
            for (Track item : items) {
                Map<String, Object> track = new HashMap<>();
                track.put("id", item.getId());
                track.put("title", item.getTitle());
                track.put("genre", item.getGenre());
                track.put("albumId", item.getAlbumId());
                track.put("artistId", item.getArtistId());
                track.put("duration", item.getDuration());
                track.put("popularity", item.getPopularity());
                track.put("trackNo", item.getTrackNo());
                tracks.add(track);
            }
            result.put("success", true);
            result.put("tracks", tracks);
        } catch (Exception e) {
            result.put("success", false);
            result.put("tracks", Collections.emptyList());
            result.put("message", e.getMessage());
        }
        return result;
    }

    // 아티스트별 상위7개 인기곡 조회
    @GetMapping("/artist/{id}/top-tracks")
    public Map<String, Object> getTopTracksByArtist(@PathVariable("id") String id) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Track> topTracks = trackService.selectTop7TracksByArtist(id);
            result.put("success", true);
            result.put("topTracks", topTracks);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    // 아티스트별 트랙 갯수 조회
    @GetMapping("/artist/{id}/track-count")
    public Map<String, Object> getTrackCountByArtist(@PathVariable("id") String id) {
        Map<String, Object> result = new HashMap<>();
        try {
            int trackCount = trackService.countTracksByArtist(id);
            result.put("success", true);
            result.put("trackCount", trackCount);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }

    // 트랙 아이디로 같은 앨범 상위 5곡 조회
    @GetMapping("/track/{id}/same-album-top-tracks")
    public Map<String, Object> getTop5TracksInSameAlbum(@PathVariable("id") String id) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Track> topTracks = trackService.findTop5TracksInSameAlbum(id);
            result.put("success", true);
            result.put("topTracks", topTracks);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        return result;
    }
}
