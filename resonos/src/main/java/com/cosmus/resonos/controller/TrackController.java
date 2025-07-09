package com.cosmus.resonos.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
import com.cosmus.resonos.service.ReviewLikeService;
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
    @Autowired
    private ReviewLikeService reviewLikeService;

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
        Artist artist = artistService.selectArtistByTrackId(id);
        TrackScore score = trackReviewService.getTrackScore(id);
        List<TrackReview> reviews = trackReviewService.reviewWithReviewerByTrackId(id);
        if (loginUser != null && reviews != null && !reviews.isEmpty()) {
            List<Long> reviewIds = reviews.stream()
                                        .map(TrackReview::getId)
                                        .collect(Collectors.toList());

            if (!reviewIds.isEmpty()) {
                List<Long> likedReviewIds = reviewLikeService.getUserLikedReviewIds("TRACK", reviewIds, loginUser.getId());

                for (TrackReview review : reviews) {
                    review.setIsLikedByCurrentUser(likedReviewIds.contains(review.getId()));
                }
            }
        }
        if (track == null) {
            return "redirect:/artists?error=notfound";
        }
        model.addAttribute("track", track);
        model.addAttribute("album", album);
        model.addAttribute("top5List", top5List);
        model.addAttribute("artist", artist);
        model.addAttribute("score", score);
        model.addAttribute("review", reviews);
        model.addAttribute("reviewType", "TRACK");
        return "review/track";
    }

    @GetMapping("/{id}/score-fragment")
    public String scoreRefresh(@PathVariable("id") String id, Model model) {
        TrackScore score = trackReviewService.getTrackScore(id);
        model.addAttribute("score", score);
        return "review/score :: scoreFragment";  // Thymeleaf 조각 이름 지정
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
    public ResponseEntity<?> create(@RequestParam("id") String trackId,
                              @RequestBody ReviewForm form,
                              @AuthenticationPrincipal CustomUser user) {
        try {
            TrackReview review = trackReviewService.write(trackId, form, user.getUser());
            return ResponseEntity.ok(review);
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 리뷰를 작성했습니다.");
        }
    }

    /* ── ② 수정 ────────────────────────────── */
    @PutMapping("/{id}/review/{reviewId}")
    @PreAuthorize("@reviewAuth.isAuthorOrAdmin(#p1, authentication)")
    @ResponseBody
    public ResponseEntity<?> update(@PathVariable("id") String trackId,
                              @PathVariable("reviewId") Long reviewId,
                              @RequestBody ReviewForm form) {
        boolean success = trackReviewService.update(reviewId, form);
        if (!success) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("수정 실패");
        }
        TrackReview updatedReview = trackReviewService.findById(reviewId);
        return ResponseEntity.ok(updatedReview);
    }

    /* ── ③ 삭제 ────────────────────────────── */
    @DeleteMapping("/{id}/review/{reviewId}")
    @PreAuthorize("@reviewAuth.isAuthorOrAdmin(#p1, authentication)")
    @ResponseBody
    public ResponseEntity<Void> delete(@PathVariable("id") String trackId,
                       @PathVariable("reviewId") Long reviewId) {
        trackReviewService.delete(reviewId);
        return ResponseEntity.noContent().build();  // 204 No Content 반환
    }

    @PostMapping("/track-reviews/{reviewId}/like")
    @ResponseBody
    public ResponseEntity<?> toggleReviewLike(@PathVariable("reviewId") Long reviewId,
                                                @AuthenticationPrincipal CustomUser user) {
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                                .body("로그인이 필요합니다.");
        }
        reviewLikeService.toggleLike(reviewId, user.getId(), "TRACK");

        int likeCount = reviewLikeService.countLikes(reviewId, "TRACK");
        boolean liked = reviewLikeService.isLiked(reviewId, user.getId(), "TRACK");

        return ResponseEntity.ok(Map.of("likeCount", likeCount, "liked", liked));
    }

    @PostMapping("/reviews/{reviewType}/{reviewId}/report")
    @ResponseBody
    public ResponseEntity<?> reportReview(@PathVariable("reviewType") String reviewType,
                                            @PathVariable("reviewId") Long reviewId,
                                            @AuthenticationPrincipal CustomUser user) {
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("로그인이 필요합니다.");
        }
        try {
            reviewLikeService.reportReview(reviewId, user.getId(), reviewType);
            int reportCount = reviewLikeService.countReports(reviewId, reviewType);
            return ResponseEntity.ok(Map.of("reportCount", reportCount));
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.TOO_MANY_REQUESTS)
                    .body("이미 신고한 리뷰입니다.");
        }
    }
    
}
