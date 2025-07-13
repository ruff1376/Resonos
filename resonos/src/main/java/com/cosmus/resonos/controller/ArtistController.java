package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.ArtistService;
import com.cosmus.resonos.service.TrackService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/artists")
public class ArtistController {


    @Autowired
    private ArtistService artistService;

    @Autowired
    private AlbumService albumService;

    @Autowired
    private TrackService trackService;

    // 아티스트 화면
    @GetMapping
    public String artistsInfo(@RequestParam("id") String id, Model model,
                                @AuthenticationPrincipal CustomUser user) throws Exception {
        Users loginUser = null;
        if( user != null ) {
            loginUser = user.getUser();
            model.addAttribute("loginUser", loginUser);
            
        }
        Artist artist = artistService.selectById(id);
        List<Album> albums = albumService.findAlbumsByArtistId(id);
        int albumCount = albumService.countAlbumsByArtist(id);
        int trackCount = trackService.countTracksByArtist(id);
        List<Track> top7List = trackService.selectTop7TracksByArtist(id);
        String mv_url = artistService.selectTopMvUrlByArtist(id);
        if (artist == null) {
            return "redirect:/artists?error=notfound";
        }
        model.addAttribute("artist", artist);
        model.addAttribute("mv", mv_url);
        model.addAttribute("albums", albums);
        model.addAttribute("albumCount", albumCount);
        model.addAttribute("TOP7", top7List);
        model.addAttribute("trackCount", trackCount);
        return "review/artist";  // templates/artists/detail.html 뷰 렌더링
    }


}
