package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriComponentsBuilder;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.TrackService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/list")
public class ListController {
    
    @Autowired
    private AlbumService albumService;

    @Autowired
    private TrackService trackService;

    // @GetMapping("/main")
    // public String view() {
    //     return "list/main";
    // }
    
    @GetMapping("/main")
    public String mainAlbumTrackList(Model model) throws Exception {
        List<Album> newAlbumList = albumService.mainNewList();
        List<Album> hotAlbumList = albumService.mainHotList();
        List<Track> newTrackList = trackService.mainNewList();
        List<Track> hotTrackList = trackService.mainHotList();

        long newAlbumCount = albumService.newCount();
        long hotAlbumCount = albumService.hotCount();
        long newTrackCount = trackService.newCount();
        long hotTrackCount = trackService.hotCount();

        model.addAttribute("newAlbumList", newAlbumList);
        model.addAttribute("hotAlbumList", hotAlbumList);
        model.addAttribute("newTrackList", newTrackList);
        model.addAttribute("hotTrackList", hotTrackList);

        model.addAttribute("newAlbumCount", newAlbumCount);
        model.addAttribute("hotAlbumCount", hotAlbumCount);
        model.addAttribute("newTrackCount", newTrackCount);
        model.addAttribute("hotTrackCount", hotTrackCount);

        log.info("newAlbumCount : " + newAlbumCount);
        log.info("hotAlbumCount : " + hotAlbumCount);
        log.info("newTrackCount : " + newTrackCount);
        log.info("hotTrackCount : " + hotTrackCount);

        return "list/main";
    }

    @GetMapping("/new-albums")
    public String newAlbumList(Model model, @RequestParam(value = "size", defaultValue = "30") int size, Pagination pagination) throws Exception {
        pagination.setSize(size);
        List<Album> newAlbumList = albumService.newList(pagination);
        model.addAttribute("pagination", pagination);
        model.addAttribute("newAlbumList", newAlbumList);
        String pageUri = UriComponentsBuilder.fromPath("/list/new-albums")
                                            .queryParam("size", pagination.getSize())
                                            .queryParam("count", pagination.getCount())
                                            .build()
                                            .toUriString();
        model.addAttribute("pageUri", pageUri);
        return "list/new_album";
    }

    @GetMapping("/hot-albums")
    public String hotAlbumList(Model model, @RequestParam(value = "size", defaultValue = "30") int size, Pagination pagination) throws Exception {
        pagination.setSize(size);
        List<Album> hotAlbumList = albumService.hotList(pagination);
        model.addAttribute("pagination", pagination);
        model.addAttribute("hotAlbumList", hotAlbumList);
        String pageUri = UriComponentsBuilder.fromPath("/list/hot-albums")
                                            .queryParam("size", pagination.getSize())
                                            .queryParam("count", pagination.getCount())
                                            .build()
                                            .toUriString();
        model.addAttribute("pageUri", pageUri);
        return "list/hot_album";
    }

    @GetMapping("/new-tracks")
    public String newTrackList(Model model, @RequestParam(value = "size", defaultValue = "30") int size, Pagination pagination) throws Exception {
        pagination.setSize(size);
        List<Track> newTrackList = trackService.newList(pagination);
        model.addAttribute("pagination", pagination);
        model.addAttribute("newTrackList", newTrackList);
        String pageUri = UriComponentsBuilder.fromPath("/list/new-tracks")
                                            .queryParam("size", pagination.getSize())
                                            .queryParam("count", pagination.getCount())
                                            .build()
                                            .toUriString();
        model.addAttribute("pageUri", pageUri);
        return "list/new_track";
    }

    @GetMapping("/hot-tracks")
    public String hotTrackList(Model model, @RequestParam(value = "size", defaultValue = "30") int size, Pagination pagination) throws Exception {
        pagination.setSize(size);
        List<Track> hotTrackList = trackService.hotList(pagination);
        model.addAttribute("pagination", pagination);
        model.addAttribute("hotTrackList", hotTrackList);
        String pageUri = UriComponentsBuilder.fromPath("/list/hot-tracks")
                                            .queryParam("size", pagination.getSize())
                                            .queryParam("count", pagination.getCount())
                                            .build()
                                            .toUriString();
        model.addAttribute("pageUri", pageUri);
        return "list/hot_track";
    }
    
}
