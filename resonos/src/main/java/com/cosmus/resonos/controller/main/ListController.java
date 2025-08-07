package com.cosmus.resonos.controller.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.review.Album;
import com.cosmus.resonos.domain.review.Track;
import com.cosmus.resonos.domain.user.Playlist;
import com.cosmus.resonos.service.review.AlbumService;
import com.cosmus.resonos.service.review.TrackService;
import com.cosmus.resonos.service.user.PlaylistService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@RestController
@RequestMapping("/list")
public class ListController {

    @Autowired
    private AlbumService albumService;

    @Autowired
    private TrackService trackService;

    @Autowired
    private PlaylistService playlistService;

    // @GetMapping("/main")
    // public String mainAlbumTrackList(Model model) throws Exception {
    //     List<Album> korHotReviewAlbumList = albumService.korHotReviewList();
    //     List<Album> worldHotReviewAlbumList = albumService.worldHotReviewList();
    //     List<Album> newAlbumList = albumService.mainNewList();
    //     List<Album> hotAlbumList = albumService.mainHotList();
    //     List<Track> newTrackList = trackService.mainNewList();
    //     List<Track> hotTrackList = trackService.mainHotList();
    //     List<Playlist> newPlaylistList = playlistService.mainNewList();
    //     List<Playlist> hotPlaylistList = playlistService.mainHotList();

    //     long newAlbumCount = albumService.newCount();
    //     long hotAlbumCount = albumService.hotCount();
    //     long newTrackCount = trackService.newCount();
    //     long hotTrackCount = trackService.hotCount();
    //     long newPlaylistCount = playlistService.newCount();
    //     long hotPlaylistCount = playlistService.hotCount();

    //     model.addAttribute("korHotReviewAlbumList", korHotReviewAlbumList);
    //     model.addAttribute("worldHotReviewAlbumList", worldHotReviewAlbumList);
    //     model.addAttribute("newAlbumList", newAlbumList);
    //     model.addAttribute("hotAlbumList", hotAlbumList);
    //     model.addAttribute("newTrackList", newTrackList);
    //     model.addAttribute("hotTrackList", hotTrackList);
    //     model.addAttribute("newPlaylistList", newPlaylistList);
    //     model.addAttribute("hotPlaylistList", hotPlaylistList);

    //     model.addAttribute("newAlbumCount", newAlbumCount);
    //     model.addAttribute("hotAlbumCount", hotAlbumCount);
    //     model.addAttribute("newTrackCount", newTrackCount);
    //     model.addAttribute("hotTrackCount", hotTrackCount);
    //     model.addAttribute("newPlaylistCount", newPlaylistCount);
    //     model.addAttribute("hotPlaylistCount", hotPlaylistCount);

    //     log.info("newAlbumCount : " + newAlbumCount);
    //     log.info("hotAlbumCount : " + hotAlbumCount);
    //     log.info("newTrackCount : " + newTrackCount);
    //     log.info("hotTrackCount : " + hotTrackCount);
    //     log.info("newPlaylistCount : " + newPlaylistCount);
    //     log.info("hotPlaylistCount : " + hotPlaylistCount);

    //     return "list/main";
    // }
    
    // @GetMapping("/new-albums")
    // public String newAlbumList(Model model, @RequestParam(value = "size", defaultValue = "30") int size, Pagination pagination) throws Exception {
    //     pagination.setSize(size);
    //     List<Album> newAlbumList = albumService.newList(pagination);
    //     model.addAttribute("pagination", pagination);
    //     model.addAttribute("newAlbumList", newAlbumList);
    //     String pageUri = UriComponentsBuilder.fromPath("/list/new-albums")
    //                                         .queryParam("size", pagination.getSize())
    //                                         .queryParam("count", pagination.getCount())
    //                                         .build()
    //                                         .toUriString();
    //     model.addAttribute("pageUri", pageUri);
    //     return "list/new_album";
    // }
    
    // @GetMapping("/hot-albums")
    // public String hotAlbumList(Model model, @RequestParam(value = "size", defaultValue = "30") int size, Pagination pagination) throws Exception {
    //     pagination.setSize(size);
    //     List<Album> hotAlbumList = albumService.hotList(pagination);
    //     model.addAttribute("pagination", pagination);
    //     model.addAttribute("hotAlbumList", hotAlbumList);
    //     String pageUri = UriComponentsBuilder.fromPath("/list/hot-albums")
    //                                         .queryParam("size", pagination.getSize())
    //                                         .queryParam("count", pagination.getCount())
    //                                         .build()
    //                                         .toUriString();
    //     model.addAttribute("pageUri", pageUri);
    //     return "list/hot_album";
    // }
    
    // @GetMapping("/new-tracks")
    // public String newTrackList(Model model, @RequestParam(value = "size", defaultValue = "30") int size, Pagination pagination) throws Exception {
    //     pagination.setSize(size);
    //     List<Track> newTrackList = trackService.newList(pagination);
    //     model.addAttribute("pagination", pagination);
    //     model.addAttribute("newTrackList", newTrackList);
    //     String pageUri = UriComponentsBuilder.fromPath("/list/new-tracks")
    //                                         .queryParam("size", pagination.getSize())
    //                                         .queryParam("count", pagination.getCount())
    //                                         .build()
    //                                         .toUriString();
    //     model.addAttribute("pageUri", pageUri);
    //     return "list/new_track";
    // }
    
    // @GetMapping("/hot-tracks")
    // public String hotTrackList(Model model, @RequestParam(value = "size", defaultValue = "30") int size, Pagination pagination) throws Exception {
    //     pagination.setSize(size);
    //     List<Track> hotTrackList = trackService.hotList(pagination);
    //     model.addAttribute("pagination", pagination);
    //     model.addAttribute("hotTrackList", hotTrackList);
    //     String pageUri = UriComponentsBuilder.fromPath("/list/hot-tracks")
    //                                         .queryParam("size", pagination.getSize())
    //                                         .queryParam("count", pagination.getCount())
    //                                         .build()
    //                                         .toUriString();
    //     model.addAttribute("pageUri", pageUri);
    //     return "list/hot_track";
    // }
    
    // @GetMapping("/new-playlists")
    // public String newPlaylistList(Model model, @RequestParam(value = "size", defaultValue = "30") int size, Pagination pagination) throws Exception {
    //     pagination.setSize(size);
    //     List<Playlist> newPlaylistList = playlistService.newList(pagination);
    //     model.addAttribute("pagination", pagination);
    //     model.addAttribute("newPlaylistList", newPlaylistList);
    //     String pageUri = UriComponentsBuilder.fromPath("/list/new-playlists")
    //                                         .queryParam("size", pagination.getSize())
    //                                         .queryParam("count", pagination.getCount())
    //                                         .build()
    //                                         .toUriString();
    //     model.addAttribute("pageUri", pageUri);
    //     return "list/new_playlist";
    // }
    
    // @GetMapping("/hot-playlists")
    // public String hotPlaylistList(Model model, @RequestParam(value = "size", defaultValue = "30") int size, Pagination pagination) throws Exception {
    //     pagination.setSize(size);
    //     List<Playlist> hotPlaylistList = playlistService.hotList(pagination);
    //     model.addAttribute("pagination", pagination);
    //     model.addAttribute("hotPlaylistList", hotPlaylistList);
    //     String pageUri = UriComponentsBuilder.fromPath("/list/hot-playlists")
    //                                         .queryParam("size", pagination.getSize())
    //                                         .queryParam("count", pagination.getCount())
    //                                         .build()
    //                                         .toUriString();
    //     model.addAttribute("pageUri", pageUri);
    //     return "list/hot_playlist";
    // }

    @GetMapping("/main")
    public ResponseEntity<Map<String, Object>> mainAlbumTrackList() throws Exception {
        Map<String, Object> result = new HashMap<>();

        result.put("korHotReviewAlbumList", albumService.korHotReviewList());
        result.put("worldHotReviewAlbumList", albumService.worldHotReviewList());
        result.put("newAlbumList", albumService.mainNewList());
        result.put("hotAlbumList", albumService.mainHotList());
        result.put("newTrackList", trackService.mainNewList());
        result.put("hotTrackList", trackService.mainHotList());
        result.put("newPlaylistList", playlistService.mainNewList());
        result.put("hotPlaylistList", playlistService.mainHotList());

        result.put("newAlbumCount", albumService.newCount());
        result.put("hotAlbumCount", albumService.hotCount());
        result.put("newTrackCount", trackService.newCount());
        result.put("hotTrackCount", trackService.hotCount());
        result.put("newPlaylistCount", playlistService.newCount());
        result.put("hotPlaylistCount", playlistService.hotCount());

        return ResponseEntity.ok(result);
    }

    @GetMapping("/new-albums")
    public ResponseEntity<Map<String, Object>> newAlbumList(
        @RequestParam(value = "size", defaultValue = "30") int size,
        Pagination pagination) throws Exception {

        pagination.setSize(size);
        List<Album> list = albumService.newList(pagination);

        Map<String, Object> response = new HashMap<>();
        response.put("pagination", pagination);
        response.put("newAlbumList", list);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/hot-albums")
    public ResponseEntity<Map<String, Object>> hotAlbumList(
        @RequestParam(value = "size", defaultValue = "30") int size,
        Pagination pagination) throws Exception {

        pagination.setSize(size);
        List<Album> list = albumService.hotList(pagination);

        Map<String, Object> response = new HashMap<>();
        response.put("pagination", pagination);
        response.put("hotAlbumList", list);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/new-tracks")
    public ResponseEntity<Map<String, Object>> newTrackList(
        @RequestParam(value = "size", defaultValue = "30") int size,
        Pagination pagination) throws Exception {

        pagination.setSize(size);
        List<Track> list = trackService.newList(pagination);

        Map<String, Object> response = new HashMap<>();
        response.put("pagination", pagination);
        response.put("newTrackList", list);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/hot-tracks")
    public ResponseEntity<Map<String, Object>> hotTrackList(
        @RequestParam(value = "size", defaultValue = "30") int size,
        Pagination pagination) throws Exception {

        pagination.setSize(size);
        List<Track> list = trackService.hotList(pagination);

        Map<String, Object> response = new HashMap<>();
        response.put("pagination", pagination);
        response.put("hotTrackList", list);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/new-playlists")
    public ResponseEntity<Map<String, Object>> newPlaylistList(
        @RequestParam(value = "size", defaultValue = "30") int size,
        Pagination pagination) throws Exception {

        pagination.setSize(size);
        List<Playlist> list = playlistService.newList(pagination);

        Map<String, Object> response = new HashMap<>();
        response.put("pagination", pagination);
        response.put("newPlaylistList", list);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/hot-playlists")
    public ResponseEntity<Map<String, Object>> hotPlaylistList(
        @RequestParam(value = "size", defaultValue = "30") int size,
        Pagination pagination) throws Exception {

        pagination.setSize(size);
        List<Playlist> list = playlistService.hotList(pagination);

        Map<String, Object> response = new HashMap<>();
        response.put("pagination", pagination);
        response.put("hotPlaylistList", list);
        return ResponseEntity.ok(response);
    }

}
