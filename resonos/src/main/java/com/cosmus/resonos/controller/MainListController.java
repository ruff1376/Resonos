package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.TrackService;

import groovy.util.logging.Slf4j;



@Slf4j
@Controller
@RequestMapping("/list")
public class MainListController {
    
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
    
}
