package com.cosmus.resonos.controller.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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

    @GetMapping("")
    public Map<String, Object> search(@RequestParam("q") String keyword) throws Exception {
        keyword = keyword.trim();
        Map<String, Object> result = new HashMap<>();

        if (keyword.startsWith("#")) {
            String tagName = keyword.substring(1);
            List<Track> tracks = trackService.searchTracksByTag(tagName);
            result.put("tracksByTag", tracks);
            result.put("keyword", keyword);
            return result;
        }

        result.put("artists", artistService.searchList(keyword));
        result.put("albums", albumService.searchList(keyword));
        result.put("tracks", trackService.searchList(keyword));
        result.put("users", userService.searchList(keyword));
        result.put("playlists", playlistService.searchList(keyword));

        result.put("artistCount", artistService.searchCount(keyword));
        result.put("albumCount", albumService.searchCount(keyword));
        result.put("trackCount", trackService.searchCount(keyword));
        result.put("userCount", userService.searchCount(keyword));
        result.put("playlistCount", playlistService.searchCount(keyword));

        return result;
    }

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

    @GetMapping("/artists")
    public Map<String, Object> artistSearch(
        @RequestParam("q") String keyword,
        @RequestParam(defaultValue = "30") int size,
        @RequestParam(defaultValue = "1") int page,
        Pagination pagination) throws Exception {

        keyword = keyword.trim();
        pagination.setSize(size);
        pagination.setPage(page);
        pagination.setCount(10);

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("keyword", keyword);
        paramMap.put("index", pagination.getIndex());
        paramMap.put("size", pagination.getSize());
        paramMap.put("pagination", pagination);

        Map<String, Object> result = new HashMap<>();
        result.put("artists", artistService.allSearchList(paramMap));
        result.put("count", artistService.searchCount(keyword));
        result.put("pagination", pagination);

        return result;
    }

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

    @GetMapping("/albums")
    public Map<String, Object> albumSearch(
        @RequestParam("q") String keyword,
        @RequestParam(defaultValue = "30") int size,
        @RequestParam(defaultValue = "1") int page,
        @RequestParam(defaultValue = "relevance") String sort,
        Pagination pagination) throws Exception {

        keyword = keyword.trim();
        pagination.setSize(size);
        pagination.setPage(page);
        pagination.setCount(10);

        Map<String, Object> result = new HashMap<>();
        result.put("albums", albumService.allSearchList(keyword, pagination, sort));
        result.put("count", albumService.searchCount(keyword));
        result.put("pagination", pagination);

        return result;
    }

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

    @GetMapping("/tracks")
    public Map<String, Object> trackSearch(
        @RequestParam("q") String keyword,
        @RequestParam(defaultValue = "30") int size,
        @RequestParam(defaultValue = "1") int page,
        @RequestParam(defaultValue = "relevance") String sort,
        Pagination pagination) throws Exception {

        keyword = keyword.trim();
        pagination.setSize(size);
        pagination.setPage(page);
        pagination.setCount(10);

        Map<String, Object> result = new HashMap<>();
        result.put("tracks", trackService.allSearchList(keyword, pagination, sort));
        result.put("count", trackService.searchCount(keyword));
        result.put("pagination", pagination);

        return result;
    }

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

    @GetMapping("/users")
    public Map<String, Object> userSearch(
        @RequestParam("q") String keyword,
        @RequestParam(defaultValue = "30") int size,
        @RequestParam(defaultValue = "1") int page,
        Pagination pagination) throws Exception {

        keyword = keyword.trim();
        pagination.setSize(size);
        pagination.setPage(page);
        pagination.setCount(10);

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("keyword", keyword);
        paramMap.put("index", pagination.getIndex());
        paramMap.put("size", pagination.getSize());
        paramMap.put("pagination", pagination);

        Map<String, Object> result = new HashMap<>();
        result.put("users", userService.allSearchList(paramMap));
        result.put("count", userService.searchCount(keyword));
        result.put("pagination", pagination);

        return result;
    }

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

    @GetMapping("/playlists")
    public Map<String, Object> playlistSearch(
        @RequestParam("q") String keyword,
        @RequestParam(defaultValue = "30") int size,
        @RequestParam(defaultValue = "1") int page,
        @RequestParam(defaultValue = "relevance") String sort,
        Pagination pagination) throws Exception {

        keyword = keyword.trim();
        pagination.setSize(size);
        pagination.setPage(page);
        pagination.setCount(10);

        Map<String, Object> result = new HashMap<>();
        result.put("playlists", playlistService.allSearchList(keyword, pagination, sort));
        result.put("count", playlistService.searchCount(keyword));
        result.put("pagination", pagination);

        return result;
    }

}
