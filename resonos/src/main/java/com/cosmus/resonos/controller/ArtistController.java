package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.ArtistService;
import com.cosmus.resonos.service.TrackService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/artists")
public class ArtistController {


    // @GetMapping({"/", ""})
    // public String artist() {
    //     return "review/artist";
    // }
    

    @Autowired
    private ArtistService artistService;

    @Autowired
    private AlbumService albumService;

    @Autowired
    private TrackService trackService;

    // // 아티스트 목록 화면
    // @GetMapping
    // public String list(Model model) throws Exception {
    //     log.info("[ArtistController] 아티스트 목록 요청");
    //     List<Artist> artists = artistService.list();
    //     log.info("[ArtistController] 아티스트 수: {}", artists.size());
    //     model.addAttribute("artists", artists);
    //     return "artist/list"; // artist/list.html
    // }

    // 아티스트 화면
    @GetMapping
    public String artistsInfo(@RequestParam("id") String id, Model model) throws Exception {
    Artist artist = artistService.selectById(id);
    List<Album> albums = albumService.findAlbumsByArtistId(id);
    int albumCount = albumService.countAlbumsByArtist(id);
    int trackCount = trackService.countTracksByArtist(id);
    List<Track> top7List = trackService.selectTop7TracksByArtist(id);
    if (artist == null) {
        return "redirect:/artists?error=notfound";
    }
    model.addAttribute("artist", artist);
    model.addAttribute("albums", albums);
    model.addAttribute("albumCount", albumCount);
    model.addAttribute("TOP7", top7List);
    model.addAttribute("trackCount", trackCount);
    return "review/artist";  // templates/artists/detail.html 뷰 렌더링
}


    // // 아티스트 등록 폼
    // @GetMapping("/new")
    // public String create(Model model) {
    //     log.info("[ArtistController] 아티스트 등록 폼 요청");
    //     model.addAttribute("artist", new Artist());
    //     return "artist/form"; // artist/form.html
    // }

    // // 아티스트 등록 처리
    // @PostMapping
    // public String createPost(@ModelAttribute Artist artist, Model model) throws Exception {
    //     log.info("[ArtistController] 아티스트 등록 시도: {}", artist);
    //     boolean success = artistService.insert(artist);
    //     if (success) {
    //         log.info("[ArtistController] 아티스트 등록 성공: {}", artist);
    //         return "redirect:/artists";
    //     }
    //     log.warn("[ArtistController] 아티스트 등록 실패: {}", artist);
    //     model.addAttribute("error", "등록 실패");
    //     return "artist/form";
    // }

    // // 아티스트 수정 폼
    // @GetMapping("/{id}/edit")
    // public String update(@PathVariable String id, Model model) throws Exception {
    //     log.info("[ArtistController] 아티스트 수정 폼 요청 - id: {}", id);
    //     Artist artist = artistService.select(Integer.valueOf(id));
    //     if (artist == null) {
    //         log.warn("[ArtistController] 수정할 아티스트 없음 - id: {}", id);
    //         return "redirect:/artists?error=notfound";
    //     }
    //     model.addAttribute("artist", artist);
    //     return "artist/form";
    // }

    // // 아티스트 수정 처리
    // @PostMapping("/{id}/edit")
    // public String updatePost(@PathVariable String id, @ModelAttribute Artist artist, Model model) throws Exception {
    //     log.info("[ArtistController] 아티스트 수정 시도 - id: {}, artist: {}", id, artist);
    //     artist.setId(id);
    //     boolean success = artistService.update(artist);
    //     if (success) {
    //         log.info("[ArtistController] 아티스트 수정 성공 - id: {}", id);
    //         return "redirect:/artists/" + id;
    //     }
    //     log.warn("[ArtistController] 아티스트 수정 실패 - id: {}", id);
    //     model.addAttribute("error", "수정 실패");
    //     return "artist/form";
    // }

    // // 아티스트 삭제 처리
    // @PostMapping("/{id}/delete")
    // public String delete(@PathVariable String id) throws Exception {
    //     log.info("[ArtistController] 아티스트 삭제 시도 - id: {}", id);
    //     artistService.delete(id);
    //     log.info("[ArtistController] 아티스트 삭제 완료 - id: {}", id);
    //     return "redirect:/artists";
    // }
}
