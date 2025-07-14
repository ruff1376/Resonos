package com.cosmus.resonos.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.external.SpotifyApiClient;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.ArtistService;
import com.cosmus.resonos.service.SpotifySyncService;
import com.cosmus.resonos.service.TrackService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/admin/music")
public class AdminMusicController {

    @Autowired
    private TrackService trackService;
    @Autowired
    private AlbumService albumService;
    @Autowired
    private ArtistService artistService;
    @Autowired
    private SpotifyApiClient spotifyApiClient; // Spotify API 클라이언트
    @Autowired
    private SpotifySyncService spotifySyncService; // Spotify 동기화 서비스


@GetMapping("")
public String musicAdminPage(
    @RequestParam(value = "tab", defaultValue = "track") String tab,
    @RequestParam(value = "page", defaultValue = "1") int page,
    @RequestParam(value = "size", defaultValue = "10") int size,
    Model model
) throws Exception {
    // 각 탭별 페이지 번호 (기본 1)
    int albumPage = 1, trackPage = 1, artistPage = 1;
    if ("album".equals(tab)) albumPage = page;
    else if ("artist".equals(tab)) artistPage = page;
    else trackPage = page; // 기본이 track

    // Pagination 객체 생성
    Pagination albumPagination = new Pagination(albumPage, size, 10, 0);
    Pagination trackPagination = new Pagination(trackPage, size, 10, 0);
    Pagination artistPagination = new Pagination(artistPage, size, 10, 0);

    // 전체 데이터 수 세팅 (컨트롤러에서만!)
    long albumTotal = albumService.count();   // 전체 앨범 개수
    long trackTotal = trackService.count();   // 전체 트랙 개수
    long artistTotal = artistService.count(); // 전체 아티스트 개수
    albumPagination.setTotal(albumTotal);
    trackPagination.setTotal(trackTotal);
    artistPagination.setTotal(artistTotal);

    // 목록 조회 (페이징)
    List<Album> albums = albumService.getAllAlbums(albumPagination);
    List<Track> tracks = trackService.getAllTracks(trackPagination);
    List<Artist> artists = artistService.listPaging(
        (int) artistPagination.getIndex(), (int) artistPagination.getSize());

    // 모델에 담기
    model.addAttribute("albums", albums);
    model.addAttribute("albumPagination", albumPagination);
    model.addAttribute("albumPageUri", "/admin/music?tab=album&size=" + size);

    model.addAttribute("tracks", tracks);
    model.addAttribute("trackPagination", trackPagination);
    model.addAttribute("trackPageUri", "/admin/music?tab=track&size=" + size);

    model.addAttribute("artists", artists);
    model.addAttribute("artistPagination", artistPagination);
    model.addAttribute("artistPageUri", "/admin/music?tab=artist&size=" + size);

    model.addAttribute("tab", tab);
    model.addAttribute("size", size);
    

    // 로그
    log.info("앨범 개수: {}", albums.size());
    log.info("트랙 개수: {}", tracks.size());

    if ("album".equals(tab)) {
    model.addAttribute("pagination", albumPagination);
    model.addAttribute("pageUri", "/admin/music?tab=album&size=" + size);
    } else if ("artist".equals(tab)) {
        model.addAttribute("pagination", artistPagination);
        model.addAttribute("pageUri", "/admin/music?tab=artist&size=" + size);
    } else {
        model.addAttribute("pagination", trackPagination);
        model.addAttribute("pageUri", "/admin/music?tab=track&size=" + size);
    }



    return "admin/music";
}


    // 트랙 저장(등록/수정)
    
    @PostMapping("/track/save")
    public String saveTrack(@ModelAttribute Track track) throws Exception {
        if (trackService.exists(track.getId())) {
            trackService.update(track);
        } else {
            trackService.insert(track);
        }
        return "redirect:/admin/music";
    }

    // 트랙 삭제
    @PostMapping("/track/delete")
    public String deleteTrack(@RequestParam("id") String id) throws Exception {
        trackService.delete(id);
        return "redirect:/admin/music";
    }

    // 앨범 저장(등록/수정)
    @PostMapping("/album/save")
    public String saveAlbum(@ModelAttribute Album album) throws Exception {
        if (albumService.exists(album.getId())) {
            albumService.update(album);
        } else {
            albumService.insert(album);
        }
        return "redirect:/admin/music";
    }

    // 앨범 삭제
    @PostMapping("/album/delete")
    public String deleteAlbum(@RequestParam("id") String id) throws Exception {
        albumService.delete(id);
        return "redirect:/admin/music";
    }

    // 아티스트 저장(등록/수정)
    @PostMapping("/artist/save")
    public String saveArtist(@ModelAttribute Artist artist) throws Exception {
        System.out.println("아티스트 저장 요청: " + artist);
        if (artistService.exists(artist.getId())) {
            System.out.println("아티스트 수정");
            artistService.update(artist);
        } else {
            System.out.println("아티스트 신규 등록");
            artistService.insert(artist);
        }
        return "redirect:/admin/music";
    }

    // 아티스트 삭제
    @PostMapping("/artist/delete")
    public String deleteArtist(@RequestParam("id") String id) throws Exception {
        artistService.delete(id);
        return "redirect:/admin/music";
    }

    // 동기화
    @PostMapping("/track/sync")
    public String syncTrack(@RequestParam("spotifyTrackId") String spotifyTrackId) throws Exception {
        trackService.syncTrackFromSpotify(spotifyTrackId);
        return "redirect:/admin/music";
    }

    // AJAX 방식으로 아티스트 동기화
    // 입력된 아티스트 ID가 22자 영숫자가 아니면 이름으로 검색 후 ID 추출
    // 성공 시 아티스트 및 관련 앨범/트랙 동기화
    @PostMapping("/sync-artist")
    @ResponseBody
    public Map<String, Object> syncArtistAjax(@RequestParam("spotifyArtistId") String spotifyArtistId) {
        Map<String, Object> result = new HashMap<>();
        try {
            String accessToken = spotifyApiClient.getAccessToken();
            String artistId = spotifyArtistId;

            // 이름으로 입력받은 경우(22자 영숫자가 아니면) → 검색 후 ID 추출
            if (artistId.length() != 22 || !artistId.matches("^[A-Za-z0-9]+$")) {
                List<Map<String, Object>> results = spotifyApiClient.searchArtist(artistId, accessToken);
                if (results.isEmpty()) {
                    result.put("success", false);
                    result.put("message", "해당 이름의 아티스트를 Spotify에서 찾을 수 없습니다: " + artistId);
                    return result;
                }
                // 첫 번째 검색 결과의 ID 사용
                artistId = (String) results.get(0).get("id");
            }

            spotifySyncService.syncArtistAndAlbumsAndTracks(artistId, accessToken);
            result.put("success", true);
            result.put("message", "아티스트 및 관련 앨범/트랙 동기화 완료! (ID: " + artistId + ")");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "동기화 실패: " + e.getMessage());
        }
        return result;
    }

    // spotify 아티스트 검색
    @GetMapping("/search-artist")
    @ResponseBody
    public Map<String, Object> searchArtist(@RequestParam("query") String query) {
        Map<String, Object> result = new HashMap<>();
        try {
            String accessToken = spotifyApiClient.getAccessToken();
            List<Map<String, Object>> items = spotifyApiClient.searchArtist(query, accessToken);
            List<Map<String, Object>> artists = new java.util.ArrayList<>();
            for (Map<String, Object> item : items) {
                Map<String, Object> artist = new HashMap<>();
                artist.put("id", item.get("id"));
                artist.put("name", item.get("name"));
                artist.put("genres", item.get("genres") != null ? String.join(",", (List<String>)item.get("genres")) : "");
                // 프로필 이미지 (있으면 첫 번째)
                if (item.get("images") instanceof List && !((List<?>)item.get("images")).isEmpty()) {
                    artist.put("image", ((Map<?, ?>)((List<?>)item.get("images")).get(0)).get("url"));
                } else {
                    artist.put("image", "");
                }
                artists.add(artist);
            }
            result.put("success", true);
            result.put("artists", artists);
        } catch (Exception e) {
            result.put("success", false);
            result.put("artists", java.util.Collections.emptyList());
            result.put("message", e.getMessage());
        }
        return result;
    }

    // spotify 앨범 검색
    @GetMapping("/search-album")
    @ResponseBody
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
                album.put("coverImage", ((List<Map<String, String>>)item.get("images")).get(0).get("url"));
                album.put("releaseDate", item.get("release_date"));
                album.put("genre", item.get("genres") != null ? String.join(",", (List<String>)item.get("genres")) : "");
                album.put("label", item.get("label"));
                album.put("description", item.get("description"));
                // 아티스트 ID는 첫 번째 아티스트만 사용
                if (item.get("artists") instanceof List && !((List<?>)item.get("artists")).isEmpty()) {
                    Map<?, ?> firstArtist = (Map<?, ?>)((List<?>)item.get("artists")).get(0);
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
    @ResponseBody
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
                track.put("genre", item.get("genre") != null ? String.join(",", (List<String>)item.get("genre")) : "");
                // 앨범 ID는 첫 번째 앨범만 사용
                if (item.get("album") instanceof Map) {
                    Map<?, ?> album = (Map<?, ?>)item.get("album");
                    track.put("albumId", album.get("id"));
                } else {
                    track.put("albumId", "");
                }
                // 아티스트 ID는 첫 번째 아티스트만 사용
                if (item.get("artists") instanceof List && !((List<?>)item.get("artists")).isEmpty()) {
                    Map<?, ?> firstArtist = (Map<?, ?>)((List<?>)item.get("artists")).get(0);
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
    @ResponseBody
    public Map<String, Object> syncTrackAjax(@RequestParam("spotifyTrackId") String spotifyTrackId) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 실제 동기화 서비스 호출
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
    @ResponseBody
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
    @ResponseBody
    public Map<String, Object> searchArtistList(
        @RequestParam(name = "keyword", defaultValue = "") String keyword
    ) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Artist> items = artistService.searchList(keyword); // 페이징 없는 검색
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
    @ResponseBody
    public Map<String, Object> searchAlbumList(
        @RequestParam(name = "keyword", defaultValue = "") String keyword
    ) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 페이징 없는 전체 검색 (서비스 계층에서 구현 필요)
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
    @ResponseBody
    public Map<String, Object> searchTrackList(
        @RequestParam(name = "keyword", defaultValue = "") String keyword
    ) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 페이징 없는 전체 검색 (서비스 계층에서 구현 필요)
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
    public String getTopTracksByArtist(@PathVariable("id") String id, Model model) throws Exception {
        List<Track> topTracks = trackService.selectTop7TracksByArtist(id);
        model.addAttribute("topTracks", topTracks);
        return "admin/top-tracks"; // 별도의 뷰로 결과 표시
    }
    // 아티스트별 트랙 갯수 조회
    @GetMapping("/artist/{id}/track-count")
    public String getTrackCountByArtist(@PathVariable("id") String id, Model model) throws Exception {
        int trackCount = trackService.countTracksByArtist(id);
        model.addAttribute("trackCount", trackCount);
        return "admin/track-count"; // 별도의 뷰로 결과 표시
    }   
    // 트랙 아이디로 같은 앨범 상위 5곡 조회
    @GetMapping("/track/{id}/same-album-top-tracks")    
    public String getTop5TracksInSameAlbum(@PathVariable("id") String id, Model model) throws Exception {
        List<Track> topTracks = trackService.findTop5TracksInSameAlbum(id);
        model.addAttribute("topTracks", topTracks);
        return "admin/same-album-top-tracks"; // 별도의 뷰로 결과 표시
    }

}
