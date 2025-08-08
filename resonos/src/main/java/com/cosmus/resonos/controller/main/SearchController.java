package com.cosmus.resonos.controller.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.review.Track;
import com.cosmus.resonos.service.review.AlbumService;
import com.cosmus.resonos.service.review.ArtistService;
import com.cosmus.resonos.service.review.TrackService;
import com.cosmus.resonos.service.user.PlaylistService;
import com.cosmus.resonos.service.user.UserService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@RestController
@RequestMapping("/search")
public class SearchController {

    @Autowired
    private ArtistService artistService;

    @Autowired
    private AlbumService albumService;

    @Autowired
    private TrackService trackService;

    @Autowired
    private UserService userService;

    @Autowired
    private PlaylistService playlistService;

    // @GetMapping("")
    // public String search(
    //     @RequestParam("q") String keyword,
    //     Model model
    // ) throws Exception {
    //     keyword = keyword.trim();

    //     if (keyword.startsWith("#")) {
    //         String tagName = keyword.substring(1);
    //         List<Track> searchTracksByTagList = trackService.searchTracksByTag(tagName);
    //         model.addAttribute("searchTracksByTagList", searchTracksByTagList);
    //         model.addAttribute("keyword", keyword);
    //         return "search/search";
    //     }

    //     List<Artist> artistSearchList = artistService.searchList(keyword);
    //     List<Album> albumSearchList = albumService.searchList(keyword);
    //     List<Track> trackSearchList = trackService.searchList(keyword);
    //     List<Users> userSearchList = userService.searchList(keyword);
    //     List<Playlist> playlistSearchList = playlistService.searchList(keyword);

    //     long artistSearchCount = artistService.searchCount(keyword);
    //     long albumSearchCount = albumService.searchCount(keyword);
    //     long trackSearchCount = trackService.searchCount(keyword);
    //     long userSearchCount = userService.searchCount(keyword);
    //     long playlistSearchCount = playlistService.searchCount(keyword);

    //     model.addAttribute("keyword", keyword);

    //     model.addAttribute("artistSearchList", artistSearchList);
    //     model.addAttribute("albumSearchList", albumSearchList);
    //     model.addAttribute("trackSearchList", trackSearchList);
    //     model.addAttribute("userSearchList", userSearchList);
    //     model.addAttribute("playlistSearchList", playlistSearchList);

    //     model.addAttribute("artistSearchCount", artistSearchCount);
    //     model.addAttribute("albumSearchCount", albumSearchCount);
    //     model.addAttribute("trackSearchCount", trackSearchCount);
    //     model.addAttribute("userSearchCount", userSearchCount);
    //     model.addAttribute("playlistSearchCount", playlistSearchCount);

    //     log.info("artistSearchCount : " + artistSearchCount);
    //     log.info("albumSearchCount : " + albumSearchCount);
    //     log.info("trackSearchCount : " + trackSearchCount);
    //     log.info("userSearchCount : " + userSearchCount);
    //     log.info("playlistSearchCount : " + playlistSearchCount);

    //     return "search/search";
    // }
    
    // @GetMapping("/artists")
    // public String artistSearch(
    //     @RequestParam("q") String keyword,
    //     @RequestParam(value = "size", defaultValue = "30") int size,
    //     @RequestParam(value = "page", defaultValue = "1") int page,
    //     Model model,
    //     Pagination pagination
    // ) throws Exception {
    //     pagination.setSize(size);
    //     pagination.setPage(page);
    //     pagination.setCount(10);

    //     Map<String, Object> paramMap = new HashMap<>();
    //     keyword = keyword.trim();
    //     paramMap.put("keyword", keyword);
    //     paramMap.put("index", pagination.getIndex());
    //     paramMap.put("size", pagination.getSize());
    //     paramMap.put("pagination", pagination);

    //     List<Artist> allArtistSearchList = artistService.allSearchList(paramMap);
    //     long artistSearchCount = artistService.searchCount(keyword);

    //     model.addAttribute("keyword", keyword);
    //     model.addAttribute("pagination", pagination);
    //     model.addAttribute("allArtistSearchList", allArtistSearchList);
    //     model.addAttribute("artistSearchCount", artistSearchCount);

    //     String pageUri = UriComponentsBuilder.fromPath("/search/artists")
    //                                         .queryParam("q", keyword)
    //                                         .queryParam("size", pagination.getSize())
    //                                         .queryParam("count", pagination.getCount())
    //                                         .build()
    //                                         .toUriString();
    //     model.addAttribute("pageUri", pageUri);

    //     log.info("artistSearchCount : " + artistSearchCount);

    //     return "search/search_artist";
    // }
    
    // @GetMapping("/albums")
    // public String albumSearch(
    //     @RequestParam("q") String keyword,
    //     @RequestParam(value = "size", defaultValue = "30") int size,
    //     @RequestParam(value = "page", defaultValue = "1") int page,
    //     @RequestParam(value = "sort", defaultValue = "relevance") String sort,
    //     Model model,
    //     Pagination pagination
    // ) throws Exception {
    //     pagination.setSize(size);
    //     pagination.setPage(page);
    //     pagination.setCount(10);

    //     // Map<String, Object> paramMap = new HashMap<>();
    //     keyword = keyword.trim();
    //     // paramMap.put("keyword", keyword);
    //     // paramMap.put("index", pagination.getIndex());
    //     // paramMap.put("size", pagination.getSize());
    //     // paramMap.put("pagination", pagination);

    //     List<Album> allAlbumSearchList = albumService.allSearchList(keyword, pagination, sort);
    //     long albumSearchCount = albumService.searchCount(keyword);

    //     model.addAttribute("keyword", keyword);
    //     model.addAttribute("pagination", pagination);
    //     model.addAttribute("allAlbumSearchList", allAlbumSearchList);
    //     model.addAttribute("sort", sort);
    //     model.addAttribute("albumSearchCount", albumSearchCount);

    //     String pageUri = UriComponentsBuilder.fromPath("/search/albums")
    //                                         .queryParam("q", keyword)
    //                                         .queryParam("size", pagination.getSize())
    //                                         .queryParam("count", pagination.getCount())
    //                                         .queryParam("sort", sort)
    //                                         .build()
    //                                         .toUriString();
    //     model.addAttribute("pageUri", pageUri);

    //     log.info("albumSearchCount : " + albumSearchCount);

    //     return "search/search_album";
    // }
    
    // @GetMapping("/tracks")
    // public String trackSearch(
    //     @RequestParam("q") String keyword,
    //     @RequestParam(value = "size", defaultValue = "30") int size,
    //     @RequestParam(value = "page", defaultValue = "1") int page,
    //     @RequestParam(value = "sort", defaultValue = "relevance") String sort,
    //     Model model,
    //     Pagination pagination
    // ) throws Exception {
    //     pagination.setSize(size);
    //     pagination.setPage(page);
    //     pagination.setCount(10);

    //     // Map<String, Object> paramMap = new HashMap<>();
    //     keyword = keyword.trim();
    //     // paramMap.put("keyword", keyword);
    //     // paramMap.put("index", pagination.getIndex());
    //     // paramMap.put("size", pagination.getSize());
    //     // paramMap.put("pagination", pagination);

    //     List<Track> allTrackSearchList = trackService.allSearchList(keyword, pagination, sort);
    //     long trackSearchCount = trackService.searchCount(keyword);

    //     model.addAttribute("keyword", keyword);
    //     model.addAttribute("pagination", pagination);
    //     model.addAttribute("allTrackSearchList", allTrackSearchList);
    //     model.addAttribute("sort", sort);
    //     model.addAttribute("trackSearchCount", trackSearchCount);

    //     String pageUri = UriComponentsBuilder.fromPath("/search/tracks")
    //                                         .queryParam("q", keyword)
    //                                         .queryParam("size", pagination.getSize())
    //                                         .queryParam("count", pagination.getCount())
    //                                         .queryParam("sort", sort)
    //                                         .build()
    //                                         .toUriString();
    //     model.addAttribute("pageUri", pageUri);

    //     log.info("trackSearchCount : " + trackSearchCount);

    //     return "search/search_track";
    // }
    
    // @GetMapping("/users")
    // public String userSearch(
    //     @RequestParam("q") String keyword,
    //     @RequestParam(value = "size", defaultValue = "30") int size,
    //     @RequestParam(value = "page", defaultValue = "1") int page,
    //     Model model,
    //     Pagination pagination
    // ) throws Exception {
    //     pagination.setSize(size);
    //     pagination.setPage(page);
    //     pagination.setCount(10);

    //     Map<String, Object> paramMap = new HashMap<>();
    //     keyword = keyword.trim();
    //     paramMap.put("keyword", keyword);
    //     paramMap.put("index", pagination.getIndex());
    //     paramMap.put("size", pagination.getSize());
    //     paramMap.put("pagination", pagination);

    //     List<Users> allUserSearchList = userService.allSearchList(paramMap);
    //     long userSearchCount = userService.searchCount(keyword);

    //     model.addAttribute("keyword", keyword);
    //     model.addAttribute("pagination", pagination);
    //     model.addAttribute("allUserSearchList", allUserSearchList);
    //     model.addAttribute("userSearchCount", userSearchCount);

    //     String pageUri = UriComponentsBuilder.fromPath("/search/users")
    //                                         .queryParam("q", keyword)
    //                                         .queryParam("size", pagination.getSize())
    //                                         .queryParam("count", pagination.getCount())
    //                                         .build()
    //                                         .toUriString();
    //     model.addAttribute("pageUri", pageUri);

    //     log.info("userSearchCount : " + userSearchCount);

    //     return "search/search_user";
    // }
    
    // @GetMapping("/playlists")
    // public String playlistSearch(
    //     @RequestParam("q") String keyword,
    //     @RequestParam(value = "size", defaultValue = "30") int size,
    //     @RequestParam(value = "page", defaultValue = "1") int page,
    //     @RequestParam(value = "sort", defaultValue = "relevance") String sort,
    //     Model model,
    //     Pagination pagination
    // ) throws Exception {
    //     pagination.setSize(size);
    //     pagination.setPage(page);
    //     pagination.setCount(10);

    //     // Map<String, Object> paramMap = new HashMap<>();
    //     keyword = keyword.trim();
    //     // paramMap.put("keyword", keyword);
    //     // paramMap.put("index", pagination.getIndex());
    //     // paramMap.put("size", pagination.getSize());
    //     // paramMap.put("pagination", pagination);

    //     List<Playlist> allPlaylistSearchList = playlistService.allSearchList(keyword, pagination, sort);
    //     long playlistSearchCount = playlistService.searchCount(keyword);

    //     model.addAttribute("keyword", keyword);
    //     model.addAttribute("pagination", pagination);
    //     model.addAttribute("allPlaylistSearchList", allPlaylistSearchList);
    //     model.addAttribute("sort", sort);
    //     model.addAttribute("playlistSearchCount", playlistSearchCount);

    //     String pageUri = UriComponentsBuilder.fromPath("/search/playlists")
    //                                         .queryParam("q", keyword)
    //                                         .queryParam("size", pagination.getSize())
    //                                         .queryParam("count", pagination.getCount())
    //                                         .queryParam("sort", sort)
    //                                         .build()
    //                                         .toUriString();
    //     model.addAttribute("pageUri", pageUri);

    //     log.info("playlistSearchCount : " + playlistSearchCount);

    //     return "search/search_playlist";
    // }

    @GetMapping("")
    public ResponseEntity<?> search(@RequestParam("q") String keyword) throws Exception {
        keyword = keyword.trim();
        Map<String, Object> response = new HashMap<>();

        if (keyword.startsWith("#")) {
            String tagName = keyword.substring(1);
            List<Track> searchTracksByTagList = trackService.searchTracksByTag(tagName);
            response.put("searchTracksByTagList", searchTracksByTagList);
            response.put("keyword", keyword);
            return new ResponseEntity<>(response, HttpStatus.OK);
        }

        response.put("artistSearchList", artistService.searchList(keyword));
        response.put("albumSearchList", albumService.searchList(keyword));
        response.put("trackSearchList", trackService.searchList(keyword));
        response.put("userSearchList", userService.searchList(keyword));
        response.put("playlistSearchList", playlistService.searchList(keyword));

        response.put("artistSearchCount", artistService.searchCount(keyword));
        response.put("albumSearchCount", albumService.searchCount(keyword));
        response.put("trackSearchCount", trackService.searchCount(keyword));
        response.put("userSearchCount", userService.searchCount(keyword));
        response.put("playlistSearchCount", playlistService.searchCount(keyword));

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/artists")
    public ResponseEntity<?> artistSearch(
        @RequestParam("q") String keyword,
        @RequestParam(value = "size", defaultValue = "30") int size,
        // @RequestParam(value = "page", defaultValue = "1") int page,
        Pagination pagination) throws Exception {

        keyword = keyword.trim();
        pagination.setSize(size);
        // pagination.setPage(page);

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("keyword", keyword);
        // paramMap.put("index", pagination.getIndex());
        // paramMap.put("size", pagination.getSize());
        paramMap.put("pagination", pagination);

        Map<String, Object> response = new HashMap<>();
        response.put("artistSearchList", artistService.allSearchList(paramMap));
        response.put("artistSearchCount", artistService.searchCount(keyword));
        response.put("pagination", pagination);

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/albums")
    public ResponseEntity<?> albumSearch(
        @RequestParam("q") String keyword,
        @RequestParam(value = "size", defaultValue = "30") int size,
        @RequestParam(value = "sort", defaultValue = "relevance") String sort,
        Pagination pagination) throws Exception {

        keyword = keyword.trim();
        pagination.setSize(size);

        Map<String, Object> response = new HashMap<>();
        response.put("albumSearchList", albumService.allSearchList(keyword, pagination, sort));
        response.put("albumSearchCount", albumService.searchCount(keyword));
        response.put("pagination", pagination);

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/tracks")
    public ResponseEntity<?> trackSearch(
        @RequestParam("q") String keyword,
        @RequestParam(value = "size", defaultValue = "30") int size,
        @RequestParam(value = "sort", defaultValue = "relevance") String sort,
        Pagination pagination) throws Exception {

        keyword = keyword.trim();
        pagination.setSize(size);

        Map<String, Object> response = new HashMap<>();
        response.put("trackSearchList", trackService.allSearchList(keyword, pagination, sort));
        response.put("trackSearchCount", trackService.searchCount(keyword));
        response.put("pagination", pagination);

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/users")
    public ResponseEntity<?> userSearch(
        @RequestParam("q") String keyword,
        @RequestParam(value = "size", defaultValue = "30") int size,
        Pagination pagination) throws Exception {

        keyword = keyword.trim();
        pagination.setSize(size);

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("keyword", keyword);
        paramMap.put("pagination", pagination);

        Map<String, Object> response = new HashMap<>();
        response.put("userSearchList", userService.allSearchList(paramMap));
        response.put("userSearchCount", userService.searchCount(keyword));
        response.put("pagination", pagination);

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/playlists")
    public ResponseEntity<?> playlistSearch(
        @RequestParam("q") String keyword,
        @RequestParam(value = "size", defaultValue = "30") int size,
        @RequestParam(value = "sort", defaultValue = "relevance") String sort,
        Pagination pagination) throws Exception {

        keyword = keyword.trim();
        pagination.setSize(size);

        Map<String, Object> response = new HashMap<>();
        response.put("playlistSearchList", playlistService.allSearchList(keyword, pagination, sort));
        response.put("playlistSearchCount", playlistService.searchCount(keyword));
        response.put("pagination", pagination);

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

}
