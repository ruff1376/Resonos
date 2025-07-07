package com.cosmus.resonos.controller;

import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.service.TrackService;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.ArtistService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/music")
public class AdminMusicController {
    private final TrackService trackService;
    private final AlbumService albumService;
    private final ArtistService artistService;

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

    // // 아티스트 동기화
    // @PostMapping("/sync-artist")
    // public String syncArtist(@RequestParam String spotifyArtistId, Model model) throws Exception {
    // // 1. 아티스트 정보 동기화
    // artistService.syncFromSpotify(spotifyArtistId);
    // // 2. 해당 아티스트의 앨범/트랙 동기화
    // albumService.syncFromSpotifyByArtist(spotifyArtistId);
    // trackService.syncFromSpotifyByArtist(spotifyArtistId);
    // model.addAttribute("syncMessage", "아티스트 및 관련 앨범/트랙 동기화 완료!");
    // return "redirect:/admin/music";
    // }


}
