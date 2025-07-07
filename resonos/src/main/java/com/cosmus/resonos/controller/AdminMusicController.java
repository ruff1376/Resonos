package com.cosmus.resonos.controller;

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
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.external.SpotifyApiClient;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.ArtistService;
import com.cosmus.resonos.service.SpotifySyncService;
import com.cosmus.resonos.service.TrackService;

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

    public AdminMusicController(TrackService trackService, AlbumService albumService, ArtistService artistService) {
        this.trackService = trackService;
        this.albumService = albumService;
        this.artistService = artistService;
    }

    @GetMapping("")
    public String musicAdminPage(Model model) throws Exception {
        List<Track> tracks = trackService.list();
        List<Album> albums = albumService.list();
        List<Artist> artists = artistService.list();
        model.addAttribute("tracks", tracks);
        model.addAttribute("albums", albums);
        model.addAttribute("artists", artists);
        model.addAttribute("trackForm", new Track());
        model.addAttribute("albumForm", new Album());
        model.addAttribute("artistForm", new Artist());
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
    public String deleteTrack(@RequestParam String id) throws Exception {
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
    public String deleteAlbum(@RequestParam String id) throws Exception {
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
    public String deleteArtist(@RequestParam String id) throws Exception {
        artistService.delete(id);
        return "redirect:/admin/music";
    }

    // 동기화
    @PostMapping("/track/sync")
    public String syncTrack(@RequestParam String spotifyTrackId) throws Exception {
        trackService.syncTrackFromSpotify(spotifyTrackId);
        return "redirect:/admin/music";
    }

    // 구현 예정 
    // AJAX 방식으로 아티스트 동기화
    // 입력된 아티스트 ID가 22자 영숫자가 아니면 이름으로 검색 후 ID 추출
    // 성공 시 아티스트 및 관련 앨범/트랙 동기화
    @PostMapping("/sync-artist")
    @ResponseBody
    public Map<String, Object> syncArtistAjax(@RequestParam String spotifyArtistId) {
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

    // 아티스트 검색
    @GetMapping("/search-artist")
    @ResponseBody
    public Map<String, Object> searchArtist(@RequestParam String query) {
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

    // 아티스트 목록 조회 (페이징 처리)
    // offset: 시작 인덱스, size: 페이지 크기
    @GetMapping("/artist/list")
    @ResponseBody
    public Map<String, Object> getArtistList(@RequestParam int offset, @RequestParam int size) {
        Map<String, Object> result = new HashMap<>();
        try {
            List<Artist> artists = artistService.listPaging(offset, size);
            result.put("success", true);
            result.put("artists", artists);
        } catch (Exception e) {
            result.put("success", false);
            result.put("artists", java.util.Collections.emptyList());
            result.put("message", e.getMessage());
        }
        return result;
}





    // 아티스트별 상위7개 인기곡 조회
    @GetMapping("/artist/{id}/top-tracks")
    public String getTopTracksByArtist(@PathVariable String id, Model model) throws Exception {
        List<Track> topTracks = trackService.selectTop7TracksByArtist(id);
        model.addAttribute("topTracks", topTracks);
        return "admin/top-tracks"; // 별도의 뷰로 결과 표시
    }
    // 아티스트별 트랙 갯수 조회
    @GetMapping("/artist/{id}/track-count")
    public String getTrackCountByArtist(@PathVariable String id, Model model) throws Exception {
        int trackCount = trackService.countTracksByArtist(id);
        model.addAttribute("trackCount", trackCount);
        return "admin/track-count"; // 별도의 뷰로 결과 표시
    }   
    // 트랙 아이디로 같은 앨범 상위 5곡 조회
    @GetMapping("/track/{id}/same-album-top-tracks")    
    public String getTop5TracksInSameAlbum(@PathVariable String id, Model model) throws Exception {
        List<Track> topTracks = trackService.findTop5TracksInSameAlbum(id);
        model.addAttribute("topTracks", topTracks);
        return "admin/same-album-top-tracks"; // 별도의 뷰로 결과 표시
    }

}
