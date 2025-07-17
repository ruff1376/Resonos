package com.cosmus.resonos.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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
import com.cosmus.resonos.domain.Playlist;
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
import com.cosmus.resonos.service.PlaylistService;
import com.cosmus.resonos.service.ReviewLikeService;
import com.cosmus.resonos.service.TagService;
import com.cosmus.resonos.service.TrackMoodVoteService;
import com.cosmus.resonos.service.TrackReviewService;
import com.cosmus.resonos.service.TrackService;
import com.cosmus.resonos.validation.ReviewForm;

import jakarta.validation.Valid;
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
    @Autowired
    private PlaylistService playlistService;

    // 트랙 화면
    @GetMapping
    public String trackInfo(@RequestParam("id") String id, Model model,
            @AuthenticationPrincipal CustomUser principal,
            @RequestParam(value = "reviewId", required = false) Long reviewId) throws Exception {

        Users loginUser = null;
        if (principal != null) {
            loginUser = principal.getUser();
            model.addAttribute("loginUser", loginUser);
            boolean isAdmin = principal.getAuthorities()
                    .stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
            model.addAttribute("isAdmin", isAdmin);
            System.out.println(isAdmin);
            Long userVotedMoodId = trackMoodVoteService.getUserVotedMoodId(loginUser.getId(), id);
            model.addAttribute("userVotedMoodId", userVotedMoodId);
            // ✅ 좋아요 여부 체크
            boolean isTrackLiked = likedTrackService.isLikedByUser(loginUser.getId(), id);
            model.addAttribute("isTrackLikedByUser", isTrackLiked);
            List<Playlist> userPlaylist = playlistService.usersPlaylist(loginUser.getId());
            model.addAttribute("userPlaylist", userPlaylist);
        } else {
            // 비로그인 사용자를 위해 false로 설정
            model.addAttribute("isTrackLikedByUser", false);
        }

        Track track = trackService.getTrackOrUpdate(id);
        Album album = albumService.findAlbumByTrackId(id);
        List<Track> top5List = trackService.findTop5TracksInSameAlbum(id);
        Artist artist = artistService.selectArtistByTrackId(id);
        TrackScore score = trackReviewService.getTrackScore(id);

        int page = 1;
        int size = 5;

        List<TrackReview> IndexReviews = trackReviewService.reviewWithReviewerByTrackId(id);
        // 찾는 리뷰의 순서
        if (reviewId != null) {
            int index = IntStream.range(0, IndexReviews.size())
                    .filter(i -> IndexReviews.get(i).getId().equals(reviewId))
                    .findFirst()
                    .orElse(-1);

            log.info("reviewId가 위치한 인덱스: {}", index);
            if (index != -1) {
                size = ((index + 1 - 1) / size + 1) * 5;
                model.addAttribute("size", size);
            }
        }

        List<TrackReview> reviews = trackReviewService.getMoreReviews(id, page, size);
        if (loginUser != null && reviews != null && !reviews.isEmpty()) {
            List<Long> reviewIds = reviews.stream()
                    .map(TrackReview::getId)
                    .collect(Collectors.toList());

            if (!reviewIds.isEmpty()) {
                List<Long> likedReviewIds = reviewLikeService.getUserLikedReviewIds("TRACK", reviewIds,
                        loginUser.getId());

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

        boolean emptyPlayList = true;
        List<Playlist> playLists = null;
        if (playlistService.getPlaylistsByTrackId(id) != null) {
            playLists = playlistService.getPlaylistsByTrackId(id);
            emptyPlayList = false;
        }

        model.addAttribute("emptyPlayList", emptyPlayList);
        model.addAttribute("playLists", playLists);
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

    @GetMapping("/myplaylists")
    public ResponseEntity<List<Playlist>> getMyPlaylists(@AuthenticationPrincipal CustomUser loginUser)
            throws Exception {
        if (loginUser == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }

        List<Playlist> userPlaylist = playlistService.usersPlaylist(loginUser.getId());
        return ResponseEntity.ok(userPlaylist);
    }

    @PostMapping("/playlists/{playlistId}")
    public ResponseEntity<Void> addTrackToPlaylist(@PathVariable("playlistId") Long playlistId,
            @RequestParam("id") String id) throws Exception {

        String trackId = id;
        // 단건 추가
        playlistService.insertSingleTrack(playlistId, trackId);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/refreshPlaylist/{id}")
    public ResponseEntity<List<Playlist>> refreshPlaylist(@PathVariable("id") String trackId,
            Model model) {
        return ResponseEntity.ok(playlistService.getPlaylistsByTrackId(trackId));
    }

    @GetMapping("/{id}/score-fragment")
    public String scoreRefresh(@PathVariable("id") String id, Model model) {
        TrackScore score = trackReviewService.getTrackScore(id);
        model.addAttribute("score", score);
        return "review/reviewFrag :: scoreFragment"; // Thymeleaf 조각 이름 지정
    }

    @GetMapping("/{id}/refresh-frag")
    public String reivewRefresh(@PathVariable("id") String id, Model model) {
        TrackScore score = trackReviewService.getTrackScore(id);
        model.addAttribute("score", score);
        return "review/reviewFrag :: reviewSection";
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
            List<Long> likedIds = reviewLikeService.getUserLikedReviewIds("TRACK", reviewIds,
                    principal.getUser().getId());
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
     * 
     * @param entity
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/from-playlists", consumes = "application/json")
    public ResponseEntity<?> getAjaxTracks(@RequestBody Map<String, String> data) throws Exception {
        log.info("트랙 요청 들어옴.");
        int offset = Integer.parseInt(data.get("offset").toString());
        int limit = Integer.parseInt(data.get("limit").toString());
        List<Track> trackList = trackService.addTrackList(data.get("keyword"), offset, limit);
        if (trackList != null)
            return new ResponseEntity<>(trackList, HttpStatus.OK);

        return new ResponseEntity<>("리스트 요청 실패.", HttpStatus.BAD_REQUEST);
    }

    /* ── ① 등록 ────────────────────────────── */
    @PostMapping
    @ResponseBody
    public ResponseEntity<?> create(@RequestParam("id") String trackId,
            @RequestBody @Valid ReviewForm form,
            @AuthenticationPrincipal CustomUser user) {
        try {
            TrackReview review = trackReviewService.write(trackId, form, user.getUser());
            return ResponseEntity.ok(review);
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 리뷰를 작성했습니다.");
        }
    }

    @GetMapping("/{trackId}/my-review-frag")
    public String getMyReviewFragment(@PathVariable("trackId") String trackId,
            @AuthenticationPrincipal CustomUser principal,
            Model model) throws Exception {
        Users loginUser = null;
        if (principal != null) {
            model.addAttribute("loginUser", loginUser = principal.getUser());
            boolean isAdmin = principal.getAuthorities()
                    .stream()
                    .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
            model.addAttribute("isAdmin", isAdmin);
        }
        TrackReview myReview = trackReviewService.getLastestReview(trackId, loginUser.getId());
        Track track = trackService.selectById(trackId);
        if (myReview == null) {
            return "review/reviewFrag :: empty"; // 아무것도 없는 프래그먼트로 대응 가능
        }

        model.addAttribute("reviewType", "TRACK");
        model.addAttribute("track", track);
        model.addAttribute("review", List.of(myReview)); // 리스트 형태로 전달
        model.addAttribute("hasNext", false); // 의미 없지만 구조 유지
        return "review/reviewFrag :: reviewItems";
    }

    /* ── ② 수정 ────────────────────────────── */
    @PutMapping("/{id}/review/{reviewId}")
    @PreAuthorize("@reviewAuth.isAuthorOrAdmin(#p1, 'TRACK', authentication)")
    @ResponseBody
    public ResponseEntity<?> update(@PathVariable("id") String trackId,
            @PathVariable("reviewId") Long reviewId,
            @RequestBody @Valid ReviewForm form) {
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
    public String deleteAndRefresh(@PathVariable("id") String trackId,
            @PathVariable("reviewId") Long reviewId,
            Model model) {
        trackReviewService.delete(reviewId);
        TrackScore score = trackReviewService.getTrackScore(trackId);
        model.addAttribute("score", score);
        return "review/reviewFrag :: reviewSection"; // 리뷰 섹션 프래그먼트 반환
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

    /**
     * 비동기 좋아요 한 트랙 검색
     * 
     * @param data
     * @return
     * @throws Exception
     */
    @PostMapping("/search")
    public ResponseEntity<?> searchMyTracks(
            @RequestBody Map<String, Object> data) throws Exception {
        Long userId = Long.valueOf(data.get("userId").toString());
        String keyword = data.get("keyword").toString();
        int offset = Integer.parseInt(data.get("offset").toString());
        int limit = Integer.parseInt(data.get("limit").toString());

        List<Track> trackList = trackService.likedTracks(userId, keyword, offset, limit);
        if (trackList != null)
            return new ResponseEntity<>(trackList, HttpStatus.OK);

        return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
