package com.cosmus.resonos.controller;

import java.util.HashMap;
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
import com.cosmus.resonos.domain.LikedTrack;
import com.cosmus.resonos.domain.MoodStat;
import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.Tag;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.domain.TrackMoodVote;
import com.cosmus.resonos.domain.TrackReview;
import com.cosmus.resonos.domain.TrackScore;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.ArtistService;
import com.cosmus.resonos.service.LikedTrackService;
import com.cosmus.resonos.service.MoodStatService;
import com.cosmus.resonos.service.PlaylistDetailService;
import com.cosmus.resonos.service.ReviewLikeService;
import com.cosmus.resonos.service.TagService;
import com.cosmus.resonos.service.TrackMoodVoteService;
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
    @Autowired
    private TagService tagService;
    @Autowired
    private TrackMoodVoteService trackMoodVoteService;
    @Autowired
    private MoodStatService moodStatService;
    @Autowired
    private LikedTrackService likedTrackService;

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
            .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
            model.addAttribute("isAdmin", isAdmin);
            Long userVotedMoodId = trackMoodVoteService.getUserVotedMoodId(loginUser.getId(), id);
            model.addAttribute("userVotedMoodId", userVotedMoodId);
            // ✅ 좋아요 여부 체크
            boolean isTrackLiked = likedTrackService.isLikedByUser(loginUser.getId(), id);
            model.addAttribute("isTrackLikedByUser", isTrackLiked);
        } else {
            // 비로그인 사용자를 위해 false로 설정
            model.addAttribute("isTrackLikedByUser", false);
        }

        
        Track track = trackService.selectById(id);
        Album album = albumService.findAlbumByTrackId(id);
        List<Track> top5List = trackService.findTop5TracksInSameAlbum(id);
        Artist artist = artistService.selectArtistByTrackId(id);
        TrackScore score = trackReviewService.getTrackScore(id);
        
        // List<TrackReview> reviews = trackReviewService.reviewWithReviewerByTrackId(id);
        int page = 1;
        int size = 5;

        List<TrackReview> reviews = trackReviewService.getMoreReviews(id, page, size);
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
        // ⭐ 페이징 객체 만들어서 더보기 여부 판단용
        long totalCount = trackReviewService.countByTrackId(id);
        Pagination pagination = new Pagination(page, size, 10, totalCount);
        boolean hasNext = pagination.getLast() > page;
        // 상위 6개 분위기
        List<MoodStat> moodStats = moodStatService.getTop6MoodsByTrackId(id);
        boolean isMoodEmpty = (moodStats == null || moodStats.isEmpty());
        // moodName과 voteCount 리스트로 나누기
        List<String> moodLabels = moodStats.stream()
                .map(MoodStat::getMoodName)
                .collect(Collectors.toList());

        List<Integer> moodValues = moodStats.stream()
                .map(MoodStat::getVoteCount)
                .collect(Collectors.toList());
        // ✅ 좋아요 수 조회
        int likeCount = likedTrackService.getTrackLikeCount(id);
        model.addAttribute("trackLikeCount", likeCount);
        model.addAttribute("isMoodEmpty", isMoodEmpty);
        model.addAttribute("moodLabels", moodLabels);
        model.addAttribute("moodValues", moodValues);
        model.addAttribute("tags", tagService.list());
        model.addAttribute("track", track);
        model.addAttribute("album", album);
        model.addAttribute("top5List", top5List);
        model.addAttribute("artist", artist);
        model.addAttribute("score", score);
        model.addAttribute("review", reviews);
        model.addAttribute("hasNext", hasNext);
        model.addAttribute("reviewType", "TRACK");
        if (track == null) {
            return "redirect:/artists?error=notfound";
        }
        return "review/track";
    }

    @GetMapping("/{id}/score-fragment")
    public String scoreRefresh(@PathVariable("id") String id, Model model) {
        TrackScore score = trackReviewService.getTrackScore(id);
        model.addAttribute("score", score);
        return "review/trackFrag :: scoreFragment";  // Thymeleaf 조각 이름 지정
    }

    @GetMapping("/{trackId}/reviews/more")
    public String loadMoreReviews(@PathVariable("trackId") String trackId,
                                @RequestParam(name = "page", defaultValue = "1") int page,
                                @RequestParam(name = "size", defaultValue = "5") int size,
                                Model model,
                                @AuthenticationPrincipal CustomUser principal) throws Exception {
                                    
        List<TrackReview> allReviews = trackReviewService.getMoreReviews(trackId, page, size);
        boolean hasNext = allReviews.size() > size; // ⭐ size+1개면 다음 페이지 존재
        List<TrackReview> reviews = hasNext ? allReviews.subList(0, size) : allReviews;
        if (principal != null && !reviews.isEmpty()) {
            List<Long> reviewIds = reviews.stream().map(TrackReview::getId).toList();
            List<Long> likedIds = reviewLikeService.getUserLikedReviewIds("TRACK", reviewIds, principal.getUser().getId());
            for (TrackReview r : reviews) {
                r.setIsLikedByCurrentUser(likedIds.contains(r.getId()));
            }
        }
        Track track = trackService.selectById(trackId);
        // 💡 여기서도 모델 변수명은 review
        model.addAttribute("hasNext", hasNext);
        model.addAttribute("track", track);
        model.addAttribute("review", reviews);
        model.addAttribute("reviewType", "TRACK");
        model.addAttribute("loginUser", principal != null ? principal.getUser() : null);
        model.addAttribute("isAdmin", principal != null && principal.getAuthorities().stream()
            .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN")));

        return "review/reviewFrag :: reviewItems";
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
    // // 등록후 프래그먼트 반환 비동기로
    // @GetMapping("/tracks/{trackId}/new-review-frag")
    // public String newReviewFragment(@PathVariable Long trackId, Model model) {
    //     TrackReview newReview = reviewService.getLatestReviewByTrack(trackId); // 방금 등록한 리뷰
    //     model.addAttribute("review", List.of(newReview)); // 주의: review는 List로 전달해야 함
    //     model.addAttribute("hasNext", false);             // 페이지네이션 여부
    //     return "review/reviewFrag :: reviewItems";        // fragment 이름 그대로
    // }

    /* ── ② 수정 ────────────────────────────── */
    @PutMapping("/{id}/review/{reviewId}")
    @PreAuthorize("@reviewAuth.isAuthorOrAdmin(#p1, 'TRACK', authentication)")
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
    @PreAuthorize("@reviewAuth.isAuthorOrAdmin(#p1, 'TRACK', authentication)")
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

    @PostMapping("/vote-mood")
    @ResponseBody
    public ResponseEntity<?> voteMood(@RequestBody TrackMoodVote request) throws Exception {
        // 저장 또는 수정
        trackMoodVoteService.saveOrUpdateVote(request.getUserId(), request.getTrackId(), request.getMood());

        System.out.println("🔥 요청 도착: " + request);

        if (request.getUserId() == null || request.getTrackId() == null || request.getMood() == null) {
            return ResponseEntity.badRequest().body("필수 데이터 누락");
        }
        // 응답 데이터 구성
        Long votedMoodId = trackMoodVoteService.getUserVotedMoodId(request.getUserId(), request.getTrackId());
        // 투표 저장 후 최신 mood 데이터 조회
        List<MoodStat> moodStats = moodStatService.getTop6MoodsByTrackId(request.getTrackId());

        List<Tag> tags = tagService.list();
        List<String> moodLabels = moodStats.stream()
            .map(MoodStat::getMoodName)
            .collect(Collectors.toList());
        List<Integer> moodValues = moodStats.stream()
            .map(MoodStat::getVoteCount)
            .collect(Collectors.toList());

        
        Map<String, Object> response = new HashMap<>();
        response.put("votedMoodId", votedMoodId);
        response.put("moods", tags);
        response.put("labels", moodLabels);
        response.put("values", moodValues);

        return ResponseEntity.ok(response);
    }
    @PostMapping("/toggle-like")
    @ResponseBody
    public ResponseEntity<?> toggleTrackLike(@RequestBody LikedTrack dto) throws Exception {
        boolean liked = likedTrackService.toggleLike(dto.getUserId(), dto.getTrackId());
        int count = likedTrackService.getTrackLikeCount(dto.getTrackId());

        Map<String, Object> result = new HashMap<>();
        result.put("liked", liked);
        result.put("count", count);

        return ResponseEntity.ok(result);
    }

}
