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

import groovy.util.logging.Slf4j;



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
        List<Track> newTrackList = trackService.mainNewList();
        model.addAttribute("newAlbumList", newAlbumList);
        model.addAttribute("newTrackList", newTrackList);
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
    
}
