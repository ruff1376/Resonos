package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.ArtistService;
import com.cosmus.resonos.service.TrackService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/albums")
public class AlbumController {

    // @Autowired
    // private AlbumService albumService;

    @Autowired
    private TrackService trackService;
    @Autowired
    private AlbumService albumService;
    @Autowired
    private ArtistService artistService;

    //앨범
    @GetMapping
    public String albumInfo(@RequestParam("id") String id, Model model) throws Exception {
        Track topTrack = trackService.findTopTrackByAlbumId(id);
        Album album = albumService.select(id);
        List<Track> top5List = trackService.findTop5TracksByAlbumId(id);
        List<Track> tracks = trackService.findTracksByAlbumId(id);
        Artist artist = artistService.findArtistByAlbumId(id);

    if (album == null) {
        return "redirect:/artists?error=notfound";
    }
    model.addAttribute("track", topTrack);
    model.addAttribute("album", album);
    model.addAttribute("top5List", top5List);
    model.addAttribute("tracks", tracks);
    model.addAttribute("artist", artist);
    return "review/album";
    }


}
