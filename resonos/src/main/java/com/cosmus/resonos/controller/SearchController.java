package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.ArtistService;
import com.cosmus.resonos.service.TrackService;

import groovy.util.logging.Slf4j;


@Slf4j
@Controller
@RequestMapping("/search")
public class SearchController {

    @Autowired
    private ArtistService artistService;

    @Autowired
    private AlbumService albumService;

    @Autowired
    private TrackService trackService;
    
    @GetMapping("")
    public String search(
        @RequestParam("q") String keyword,
        Model model
    ) throws Exception {
        List<Artist> artistSearchList = artistService.searchList(keyword);
        List<Album> albumSearchList = albumService.searchList(keyword);
        List<Track> trackSearchList = trackService.searchList(keyword);
        model.addAttribute("keyword", keyword);
        model.addAttribute("artistSearchList", artistSearchList);
        model.addAttribute("albumSearchList", albumSearchList);
        model.addAttribute("trackSearchList", trackSearchList);
        return "search/search";
    }
    
}
