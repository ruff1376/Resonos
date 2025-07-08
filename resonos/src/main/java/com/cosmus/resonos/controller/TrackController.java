package com.cosmus.resonos.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.domain.TrackReview;
import com.cosmus.resonos.domain.TrackScore;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.ArtistService;
import com.cosmus.resonos.service.PlaylistDetailService;
import com.cosmus.resonos.service.TrackReviewService;
import com.cosmus.resonos.service.TrackService;
import com.cosmus.resonos.validation.ReviewForm;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/tracks")
public class TrackController {


    @Autowired
    private TrackService trackService;
    @Autowired
    private AlbumService albumService;
    @Autowired
    private ArtistService artistService;
    @Autowired
    private TrackReviewService trackReviewService;
    @Autowired
    private PlaylistDetailService playlistDetailService;

    // 트랙 화면
    @GetMapping
    public String trackInfo(@RequestParam("id") String id, Model model,
                            @AuthenticationPrincipal CustomUser principal
                            ) throws Exception {

        Users loginUser = null;
        if (principal != null) {
        loginUser = principal.getUser();
        model.addAttribute("loginUser", loginUser);
        boolean isAdmin = principal.getAuthorities()
        .stream()
        .anyMatch(a -> a.getAuthority().equals("ADMIN"));
        model.addAttribute("isAdmin", isAdmin);
        }
        Track track = trackService.selectById(id);
        Album album = albumService.findAlbumByTrackId(id);
        List<Track> top5List = trackService.findTop5TracksInSameAlbum(id);
        // String artistName = trackService.findArtistNameByTrackId(id);
        Artist artist = artistService.selectArtistByTrackId(id);
        TrackScore score = trackReviewService.getTrackScore(id);
        List<TrackReview> reviews = trackReviewService.reviewWithReviewerByTrackId(id);
        if (track == null) {
            return "redirect:/artists?error=notfound";
        }
        model.addAttribute("track", track);
        model.addAttribute("album", album);
        model.addAttribute("top5List", top5List);
        model.addAttribute("artist", artist);
        model.addAttribute("score", score);
        model.addAttribute("review", reviews);
        return "review/track";
    }

    /**
     * 플레이리스트에 추가할 트랙 리스트 요청
     * @param entity
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/from-playlists", consumes = "application/json")
    public ResponseEntity<?> getAjaxTracks(@RequestBody Map<String, String> data) throws Exception {

        log.info("트랙 요청 들어옴.");
        List<Track> trackList = trackService.addTrackList(data.get("keyword"));
        if(trackList != null)
            return new ResponseEntity<>(trackList, HttpStatus.OK);

        return new ResponseEntity<>("리스트 요청 실패.", HttpStatus.BAD_REQUEST);
    }

    /* ── ① 등록 ────────────────────────────── */
    @PostMapping
    @ResponseBody
    public TrackReview create(@RequestParam("id") String trackId,
                              @RequestBody ReviewForm form,
                              @AuthenticationPrincipal CustomUser user) {
        return trackReviewService.write(trackId, form, user.getUser());
    }

    /* ── ② 수정 ────────────────────────────── */
    @PutMapping("/{id}/review/{reviewId}")
    @PreAuthorize("@reviewAuth.isAuthorOrAdmin(#reviewId, authentication)")
    public TrackReview update(@PathVariable("id") String trackId,
                              @PathVariable("reviewId") Long reviewId,
                              @RequestBody ReviewForm form) {
        return trackReviewService.update(reviewId, form);
    }

    /* ── ③ 삭제 ────────────────────────────── */
    @DeleteMapping("/{id}/review/{reviewId}")
    @PreAuthorize("@reviewAuth.isAuthorOrAdmin(#reviewId, authentication)")
    public void delete(@PathVariable("id") String trackId,
                       @PathVariable("reviewId") Long reviewId) {
        trackReviewService.delete(reviewId);
    }

    // /* ── ④ 좋아요 (선택) ───────────────────── */
    // @PostMapping("/{reviewId}/like")
    // public LikesDto like(@PathVariable Long reviewId,
    //                      @AuthenticationPrincipal CustomUser user){
    //     return trackReviewService.like(reviewId, user.getUser().getId());
    // }
    
}
