package com.cosmus.resonos.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.cosmus.resonos.domain.AlbumMoodVote;
import com.cosmus.resonos.domain.AlbumReview;
import com.cosmus.resonos.domain.AlbumScore;
import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.LikedAlbum;
import com.cosmus.resonos.domain.MoodStat;
import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.service.AlbumMoodVoteService;
import com.cosmus.resonos.service.AlbumReviewService;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.ArtistService;
import com.cosmus.resonos.service.LikedAlbumService;
import com.cosmus.resonos.service.MoodStatService;
import com.cosmus.resonos.service.ReviewLikeService;
import com.cosmus.resonos.service.TagService;
import com.cosmus.resonos.service.TrackService;
import com.cosmus.resonos.validation.ReviewForm;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/albums")
public class AlbumController {

    @Autowired
    private TrackService trackService;
    @Autowired
    private AlbumService albumService;
    @Autowired
    private AlbumReviewService albumReviewService;
    @Autowired
    private ArtistService artistService;
    @Autowired
    private ReviewLikeService reviewLikeService;
    @Autowired
    private MoodStatService moodStatService;
    @Autowired
    private LikedAlbumService likedAlbumService;
    @Autowired
    private TagService tagService;
    @Autowired
    private AlbumMoodVoteService albumMoodVoteService;

    //앨범
    @GetMapping
    public String albumInfo(@RequestParam("id") String id, Model model,
                            @AuthenticationPrincipal CustomUser principal) throws Exception {
        Users loginUser = null;
        if( principal != null ) {
            model.addAttribute("loginUser", loginUser = principal.getUser() );
            boolean isAdmin = principal.getAuthorities()
                    .stream()
                    .anyMatch( a -> a.getAuthority().equals("ROLE_ADMIN"));
            model.addAttribute("isAdmin", isAdmin);
            Long userVotedMoodId = albumMoodVoteService.getUserVotedMoodId(loginUser.getId(), id);
            model.addAttribute("userVotedMoodId", userVotedMoodId);
            // ✅ 좋아요 여부 체크
            boolean isAlbumLiked = likedAlbumService.isLikedByUser(loginUser.getId(), id);
            model.addAttribute("isAlbumLikedByUser", isAlbumLiked);
        } else {
            // 비로그인 사용자를 위해 false로 설정
            model.addAttribute("isAlbumLikedByUser", false);
        }

        AlbumScore score = albumReviewService.getAlbumScore(id);
        Track topTrack = trackService.findTopTrackByAlbumId(id);
        Album album = albumService.select(id);
        List<Track> top5List = trackService.findTop5TracksByAlbumId(id);
        List<Track> tracks = trackService.findTracksByAlbumId(id);
        Artist artist = artistService.findArtistByAlbumId(id);

        int page = 1;
        int size = 5;

        List<AlbumReview> reviews = albumReviewService.getMoreReviews(id, page, size);
        if (loginUser != null && reviews != null && !reviews.isEmpty()) {
            List<Long> reviewIds = reviews.stream().map(AlbumReview::getId).toList();
            List<Long> likedReviewIds = reviewLikeService.getUserLikedReviewIds("ALBUM", reviewIds, loginUser.getId());
            for (AlbumReview review : reviews) {
                review.setIsLikedByCurrentUser(likedReviewIds.contains(review.getId()));
            }
        }

        long totalCount = albumReviewService.countByAlbumId(id);
        Pagination pagination = new Pagination(page, size, 10, totalCount);
        boolean hasNext = pagination.getLast() > page;

        List<MoodStat> moodStats = moodStatService.getTop6MoodsByAlbumId(id);
        boolean isMoodEmpty = (moodStats == null || moodStats.isEmpty());
        List<String> moodLabels = moodStats.stream().map(MoodStat::getMoodName).toList();
        List<Integer> moodValues = moodStats.stream().map(MoodStat::getVoteCount).toList();

        int likeCount = likedAlbumService.getAlbumLikeCount(id);
        
        model.addAttribute("album", album);
        model.addAttribute("artist", artist);
        model.addAttribute("tracks", tracks);
        model.addAttribute("top5List", top5List);
        model.addAttribute("track", topTrack);
        model.addAttribute("score", score);
        model.addAttribute("review", reviews);
        model.addAttribute("hasNext", hasNext);
        model.addAttribute("tags", tagService.list());
        model.addAttribute("reviewType", "ALBUM");
        model.addAttribute("isMoodEmpty", isMoodEmpty);
        model.addAttribute("moodLabels", moodLabels);
        model.addAttribute("moodValues", moodValues);
        model.addAttribute("albumLikeCount", likeCount);

        if (album == null) {
            return "redirect:/artists?error=notfound";
        }
        
        return "review/album";
    }

    @GetMapping("/{id}/score-fragment")
    public String scoreRefresh(@PathVariable("id") String id, Model model) {
        AlbumScore score = albumReviewService.getAlbumScore(id);
        model.addAttribute("score", score);
        return "review/reviewFrag :: scoreFragment";
    }

    @GetMapping("/{albumId}/reviews/more")
    public String loadMoreReviews(@PathVariable("albumId") String albumId,
                                  @RequestParam(name = "page", defaultValue = "1") int page,
                                  @RequestParam(name = "size", defaultValue = "5") int size,
                                  Model model,
                                  @AuthenticationPrincipal CustomUser principal) throws Exception {

        List<AlbumReview> allReviews = albumReviewService.getMoreReviews(albumId, page, size);
        boolean hasNext = allReviews.size() > size;
        List<AlbumReview> reviews = hasNext ? allReviews.subList(0, size) : allReviews;

        if (principal != null && !reviews.isEmpty()) {
            List<Long> reviewIds = reviews.stream().map(AlbumReview::getId).toList();
            List<Long> likedIds = reviewLikeService.getUserLikedReviewIds("ALBUM", reviewIds, principal.getUser().getId());
            for (AlbumReview r : reviews) {
                r.setIsLikedByCurrentUser(likedIds.contains(r.getId()));
            }
        }

        Album album = albumService.select(albumId);
        model.addAttribute("hasNext", hasNext);
        model.addAttribute("album", album);
        model.addAttribute("review", reviews);
        model.addAttribute("reviewType", "ALBUM");
        model.addAttribute("loginUser", principal != null ? principal.getUser() : null);
        model.addAttribute("isAdmin", principal != null && principal.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN")));

        return "review/reviewFrag :: reviewItems";
    }

    @PostMapping
    @ResponseBody
    public ResponseEntity<?> create(@RequestParam("id") String albumId,
                                    @RequestBody ReviewForm form,
                                    @AuthenticationPrincipal CustomUser user) {
        try {
            AlbumReview review = albumReviewService.write(albumId, form, user.getUser());
            return ResponseEntity.ok(review);
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 리뷰를 작성했습니다.");
        }
    }

    @PutMapping("/{id}/review/{reviewId}")
    @PreAuthorize("@reviewAuth.isAuthorOrAdmin(#p1, 'ALBUM', authentication)")
    @ResponseBody
    public ResponseEntity<?> update(@PathVariable("id") String albumId,
                                    @PathVariable("reviewId") Long reviewId,
                                    @RequestBody ReviewForm form) {
        boolean success = albumReviewService.update(reviewId, form);
        if (!success) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("수정 실패");
        }
        AlbumReview updatedReview = albumReviewService.findById(reviewId);
        return ResponseEntity.ok(updatedReview);
    }

    @DeleteMapping("/{id}/review/{reviewId}")
    @PreAuthorize("@reviewAuth.isAuthorOrAdmin(#p1, 'ALBUM', authentication)")
    @ResponseBody
    public ResponseEntity<Void> delete(@PathVariable("id") String albumId,
                                       @PathVariable("reviewId") Long reviewId) {
        albumReviewService.delete(reviewId);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/album-reviews/{reviewId}/like")
    @ResponseBody
    public ResponseEntity<?> toggleReviewLike(@PathVariable("reviewId") Long reviewId,
                                              @AuthenticationPrincipal CustomUser user) {
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }
        reviewLikeService.toggleLike(reviewId, user.getId(), "ALBUM");
        int likeCount = reviewLikeService.countLikes(reviewId, "ALBUM");
        boolean liked = reviewLikeService.isLiked(reviewId, user.getId(), "ALBUM");
        return ResponseEntity.ok(Map.of("likeCount", likeCount, "liked", liked));
    }

    @PostMapping("/reviews/{reviewType}/{reviewId}/report")
    @ResponseBody
    public ResponseEntity<?> reportReview(@PathVariable("reviewType") String reviewType,
                                          @PathVariable("reviewId") Long reviewId,
                                          @AuthenticationPrincipal CustomUser user) {
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
        }
        try {
            reviewLikeService.reportReview(reviewId, user.getId(), reviewType);
            int reportCount = reviewLikeService.countReports(reviewId, reviewType);
            return ResponseEntity.ok(Map.of("reportCount", reportCount));
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.TOO_MANY_REQUESTS).body("이미 신고한 리뷰입니다.");
        }
    }

    @PostMapping("/vote-mood")
    @ResponseBody
    public ResponseEntity<?> voteMood(@RequestBody AlbumMoodVote request) throws Exception {
        albumMoodVoteService.saveOrUpdateVote(request.getUserId(), request.getAlbumId(), request.getMood());
        if (request.getUserId() == null || request.getAlbumId() == null || request.getMood() == null) {
            return ResponseEntity.badRequest().body("필수 데이터 누락");
        }
        Long votedMoodId = albumMoodVoteService.getUserVotedMoodId(request.getUserId(), request.getAlbumId());
        List<MoodStat> moodStats = moodStatService.getTop6MoodsByAlbumId(request.getAlbumId());
        List<String> moodLabels = moodStats.stream().map(MoodStat::getMoodName).toList();
        List<Integer> moodValues = moodStats.stream().map(MoodStat::getVoteCount).toList();
        Map<String, Object> response = new HashMap<>();
        response.put("votedMoodId", votedMoodId);
        response.put("labels", moodLabels);
        response.put("values", moodValues);
        response.put("moods", tagService.list());
        return ResponseEntity.ok(response);
    }

    @PostMapping("/toggle-like")
    @ResponseBody
    public ResponseEntity<?> toggleAlbumLike(@RequestBody LikedAlbum dto) throws Exception {
        boolean liked = likedAlbumService.toggleLike(dto.getUserId(), dto.getAlbumId());
        int count = likedAlbumService.getAlbumLikeCount(dto.getAlbumId());
        Map<String, Object> result = new HashMap<>();
        result.put("liked", liked);
        result.put("count", count);
        return ResponseEntity.ok(result);
    }

}
