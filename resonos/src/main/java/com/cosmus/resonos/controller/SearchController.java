package com.cosmus.resonos.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriComponentsBuilder;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.domain.Pagination;
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

        long artistSearchCount = artistService.searchCount(keyword);
        long albumSearchCount = albumService.searchCount(keyword);
        long trackSearchCount = trackService.searchCount(keyword);
        
        model.addAttribute("keyword", keyword);
        model.addAttribute("artistSearchList", artistSearchList);
        model.addAttribute("albumSearchList", albumSearchList);
        model.addAttribute("trackSearchList", trackSearchList);
        model.addAttribute("artistSearchCount", artistSearchCount);
        model.addAttribute("albumSearchCount", albumSearchCount);
        model.addAttribute("trackSearchCount", trackSearchCount);
        
        return "search/search";
    }

    @GetMapping("/artists")
    public String artistSearch(
        @RequestParam("q") String keyword,
        @RequestParam(value = "size", defaultValue = "30") int size,
        @RequestParam(value = "page", defaultValue = "1") int page,
        Model model,
        Pagination pagination
    ) throws Exception {
        pagination.setSize(size);
        pagination.setPage(page);
        pagination.setCount(10);

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("keyword", keyword);
        paramMap.put("index", pagination.getIndex());
        paramMap.put("size", pagination.getSize());
        paramMap.put("pagination", pagination);

        List<Artist> allArtistSearchList = artistService.allSearchList(paramMap);

        model.addAttribute("keyword", keyword);
        model.addAttribute("pagination", pagination);
        model.addAttribute("allArtistSearchList", allArtistSearchList);
        
        String pageUri = UriComponentsBuilder.fromPath("/search/artists")
                                            .queryParam("q", keyword)
                                            .queryParam("size", pagination.getSize())
                                            .queryParam("count", pagination.getCount())
                                            .build()
                                            .toUriString();
        model.addAttribute("pageUri", pageUri);
        return "search/search_artist";
    }

    @GetMapping("/albums")
    public String albumSearch(
        @RequestParam("q") String keyword,
        @RequestParam(value = "size", defaultValue = "30") int size,
        @RequestParam(value = "page", defaultValue = "1") int page,
        Model model,
        Pagination pagination
    ) throws Exception {
        pagination.setSize(size);
        pagination.setPage(page);
        pagination.setCount(10);

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("keyword", keyword);
        paramMap.put("index", pagination.getIndex());
        paramMap.put("size", pagination.getSize());
        paramMap.put("pagination", pagination);

        List<Album> allAlbumSearchList = albumService.allSearchList(paramMap);

        model.addAttribute("keyword", keyword);
        model.addAttribute("pagination", pagination);
        model.addAttribute("allAlbumSearchList", allAlbumSearchList);
        
        String pageUri = UriComponentsBuilder.fromPath("/search/albums")
                                            .queryParam("q", keyword)
                                            .queryParam("size", pagination.getSize())
                                            .queryParam("count", pagination.getCount())
                                            .build()
                                            .toUriString();
        model.addAttribute("pageUri", pageUri);
        return "search/search_album";
    }

    @GetMapping("/tracks")
    public String trackSearch(
        @RequestParam("q") String keyword,
        @RequestParam(value = "size", defaultValue = "30") int size,
        @RequestParam(value = "page", defaultValue = "1") int page,
        Model model,
        Pagination pagination
    ) throws Exception {
        pagination.setSize(size);
        pagination.setPage(page);
        pagination.setCount(10);

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("keyword", keyword);
        paramMap.put("index", pagination.getIndex());
        paramMap.put("size", pagination.getSize());
        paramMap.put("pagination", pagination);

        List<Track> allTrackSearchList = trackService.allSearchList(paramMap);

        model.addAttribute("keyword", keyword);
        model.addAttribute("pagination", pagination);
        model.addAttribute("allTrackSearchList", allTrackSearchList);
        
        String pageUri = UriComponentsBuilder.fromPath("/search/tracks")
                                            .queryParam("q", keyword)
                                            .queryParam("size", pagination.getSize())
                                            .queryParam("count", pagination.getCount())
                                            .build()
                                            .toUriString();
        model.addAttribute("pageUri", pageUri);
        return "search/search_track";
    }
    
}
