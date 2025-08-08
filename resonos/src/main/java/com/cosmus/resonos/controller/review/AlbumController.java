package com.cosmus.resonos.controller.review;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.review.Album;
import com.cosmus.resonos.domain.review.ChartElement;
import com.cosmus.resonos.domain.review.LikedAlbum;
import com.cosmus.resonos.service.review.AlbumService;
import com.cosmus.resonos.service.review.combinedServ.CombinedAlbumService;
import com.cosmus.resonos.validation.ReviewForm;

import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/albums")
@AllArgsConstructor
public class AlbumController {

    private final AlbumService albumService;
    private final CombinedAlbumService combinedAlbumService;

    // 앨범 초기페이지 로딩
    @GetMapping
    public ResponseEntity<?> albumInfo(@RequestParam("id") String albumId,
                                @AuthenticationPrincipal CustomUser user) {

        return combinedAlbumService.albumInfo(albumId, user);
    }

    // 앨범 좋아요
    @PostMapping("/like")
    public ResponseEntity<?> toggleAlbumLike(@RequestBody LikedAlbum dto) throws Exception {
        
        return combinedAlbumService.toggleAlbumLike(dto);
    }

    // 앨범 리뷰 작성 작성후에 리뷰와 갱신된 점수 리턴
    @PostMapping("/reviews")
    public ResponseEntity<?> albumReviewPost(@RequestParam("id") String albumId, @RequestBody @Valid ReviewForm form,
            @AuthenticationPrincipal CustomUser user) {

        return combinedAlbumService.albumReviewPost(albumId, form, user);
    }

    // 리뷰 더보기 hasNext boolean 값, 리뷰 리스트 리턴
    @GetMapping("/reviews/more")
    public ResponseEntity<?> loadMoreReviews(@RequestParam("id") String albumId,
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "size", defaultValue = "10") int size,
            @AuthenticationPrincipal CustomUser user) throws Exception {

        return combinedAlbumService.loadMoreReviews(albumId, page, size, user);
    }

    // 리뷰 수정
    // 폼에 리뷰아이디넣어야함
    @PutMapping("/reviews")
    // @PreAuthorize("@reviewAuth.isAuthorOrAdmin(#p1, 'ALBUM', authentication)")
    public ResponseEntity<?> update(@RequestParam("id") String albumId, Long reviewId,
            @RequestBody @Valid ReviewForm form) {

        return combinedAlbumService.update(albumId, form.getId(), form);
    }

    // 리뷰 삭제
    @DeleteMapping("/reviews/{reviewId}")
    // @PreAuthorize("@reviewAuth.isAuthorOrAdmin(#p1, 'ALBUM', authentication)")
    public ResponseEntity<?> delete(@RequestParam("id") String albumId,
                                @PathVariable("reviewId") Long reviewId) {
        
        return combinedAlbumService.delete(albumId, reviewId);
    }

    // 리뷰 좋아요
    @PostMapping("/reviews/{reviewId}")
    public ResponseEntity<?> toggleReviewLike(@PathVariable("reviewId") Long reviewId,
            @AuthenticationPrincipal CustomUser user) {
        
        return combinedAlbumService.toggleReviewLike(reviewId, user);
    }

    // 리뷰 신고
    @PostMapping("/report/{reviewId}")
    public ResponseEntity<?> reportReview(@PathVariable("reviewId") Long reviewId
                                , @AuthenticationPrincipal CustomUser user) {
        return combinedAlbumService.reportReview(reviewId, user);
    }

    // 6요소 투표
    @PostMapping("/vote")
    public ResponseEntity<?> saveOrUpdateVote(@RequestParam("id") String albumId ,@RequestBody ChartElement element,
                                    @AuthenticationPrincipal CustomUser user) {
        return combinedAlbumService.saveOrUpdateVote(albumId, element, user);
    }

    // 앨범
    // @GetMapping
    // public String albumInfo(@RequestParam("id") String id, Model model,
    //         @AuthenticationPrincipal CustomUser principal,
    //         @RequestParam(value = "reviewId", required = false) Long reviewId
    //         ) throws Exception {
    //     Users loginUser = null;
    //     if (principal != null) {
    //         model.addAttribute("loginUser", loginUser = principal.getUser());
    //         boolean isAdmin = principal.getAuthorities()
    //                 .stream()
    //                 .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
    //         model.addAttribute("isAdmin", isAdmin);
    //         // ✅ 좋아요 여부 체크
    //         boolean isAlbumLiked = likedAlbumService.isLikedByUser(loginUser.getId(), id);
    //         model.addAttribute("isAlbumLikedByUser", isAlbumLiked);
    //     } else {
    //         // 비로그인 사용자를 위해 false로 설정
    //         model.addAttribute("isAlbumLikedByUser", false);
    //     }

    //     AlbumScore score = albumReviewService.getAlbumScore(id);
    //     Track topTrack = trackService.topTrackByAlbumIdAndFetchMv(id);
    //     Album album = albumService.select(id);
    //     List<Track> top5List = trackService.findTop5TracksByAlbumId(id);
    //     List<Track> tracks = trackService.findTracksByAlbumId(id);
    //     Artist artist = artistService.findArtistByAlbumId(id);

    //     int page = 1;
    //     int size = 5;

    //     List<AlbumReview> IndexReviews = albumReviewService.reviewWithReviewerByAlbumId(id);
    //     // 찾는 리뷰의 순서
    //     if(reviewId != null) {
    //         int index = IntStream.range(0, IndexReviews.size())
    //         .filter(i -> IndexReviews.get(i).getId().equals(reviewId))
    //         .findFirst()
    //         .orElse(-1);

    //         log.info("reviewId가 위치한 인덱스: {}", index);
    //         if (index != -1) {
    //             size = ((index + 1 -1) / size + 1) * 5;
    //             model.addAttribute("size", size);
    //         }
    //     }

    //     List<AlbumReview> reviews = albumReviewService.getMoreReviews(id, page, size);

    //     if (loginUser != null && reviews != null && !reviews.isEmpty()) {
    //         List<Long> reviewIds = reviews.stream().map(AlbumReview::getId).toList();
    //         List<Long> likedReviewIds = reviewLikeService.getUserLikedReviewIds("ALBUM", reviewIds, loginUser.getId());
    //         for (AlbumReview review : reviews) {
    //             review.setIsLikedByCurrentUser(likedReviewIds.contains(review.getId()));
    //         }
    //     }

    //     long totalCount = albumReviewService.countByAlbumId(id);
    //     Pagination pagination = new Pagination(page, size, 10, totalCount);
    //     boolean hasNext = pagination.getLast() > page;

    //     int likeCount = likedAlbumService.getAlbumLikeCount(id);

    //     Map<String, Integer> argValues = chartElementService.getAverageScoresByAlbumId(id);

    //     // 요소 이름 리스트 (순서 고정)
    //     List<String> argLabels = Arrays.asList("가사", "사운드", "멜로디", "스토리텔링", "유기성", "독창성");
    //     // 요소 점수 리스트
    //     List<Integer> argScores = null;
    //     if (argValues != null && !argValues.isEmpty()) {
    //         argScores = Arrays.asList(
    //                 argValues.getOrDefault("lyric", 0),
    //                 argValues.getOrDefault("sound", 0),
    //                 argValues.getOrDefault("melody", 0),
    //                 argValues.getOrDefault("storytelling", 0),
    //                 argValues.getOrDefault("cohesiveness", 0),
    //                 argValues.getOrDefault("creativity", 0));
    //     }

    //     boolean emptyPlayList = true;
    //     List<Playlist> playLists = null;
    //     if (playlistService.getPlaylistsByAlbumId(id) != null) {
    //         playLists = playlistService.getPlaylistsByAlbumId(id);
    //         emptyPlayList = false;
    //     }
    //     model.addAttribute("emptyPlayList", emptyPlayList);
    //     model.addAttribute("playLists", playLists);
    //     model.addAttribute("argLabels", argLabels);
    //     model.addAttribute("argScores", argScores);
    //     model.addAttribute("album", album);
    //     model.addAttribute("artist", artist);
    //     model.addAttribute("tracks", tracks);
    //     model.addAttribute("top5List", top5List);
    //     model.addAttribute("track", topTrack);
    //     model.addAttribute("score", score);
    //     model.addAttribute("review", reviews);
    //     model.addAttribute("hasNext", hasNext);
    //     model.addAttribute("reviewType", "ALBUM");
    //     model.addAttribute("albumLikeCount", likeCount);

    //     if (album == null) {
    //         return "redirect:/artists?error=notfound";
    //     }

    //     return "review/album";
    // }

    // 리뷰 작성시에 점수랑 리뷰 반환요청
    // @GetMapping("/{id}/score-fragment")
    // public String scoreRefresh(@PathVariable("id") String id, Model model) {
    //     AlbumScore score = albumReviewService.getAlbumScore(id);
    //     model.addAttribute("score", score);
    //     return "review/reviewFrag :: scoreFragment";
    // }
    // @GetMapping("/{id}/refresh-frag")
    // public String reivewRefresh(@PathVariable("id") String id, Model model) {
    //     AlbumScore score = albumReviewService.getAlbumScore(id);
    //     model.addAttribute("score", score);
    //     return "review/reviewFrag :: reviewSection";
    // }

    // @GetMapping("/{albumId}/my-review-frag")
    // public String getMyReviewFragment(@PathVariable("albumId") String albumId,
    //         @AuthenticationPrincipal CustomUser principal,
    //         Model model) throws Exception {
    //     Users loginUser = null;
    //     if (principal != null) {
    //         model.addAttribute("loginUser", loginUser = principal.getUser());
    //         boolean isAdmin = principal.getAuthorities()
    //                 .stream()
    //                 .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
    //         model.addAttribute("isAdmin", isAdmin);
    //         // ✅ 좋아요 여부 체크
    //         boolean isAlbumLiked = likedAlbumService.isLikedByUser(loginUser.getId(), albumId);
    //         model.addAttribute("isAlbumLikedByUser", isAlbumLiked);
    //     } else {
    //         // 비로그인 사용자를 위해 false로 설정
    //         model.addAttribute("isAlbumLikedByUser", false);
    //     }
    //     AlbumReview myReview = albumReviewService.getLastestReview(albumId, loginUser.getId());
    //     Track track = trackService.selectById(albumId);
    //     if (myReview == null) {
    //         return "review/reviewFrag :: empty"; // 아무것도 없는 프래그먼트로 대응 가능
    //     }

    //     model.addAttribute("reviewType", "ALBUM");
    //     model.addAttribute("track", track);
    //     model.addAttribute("review", List.of(myReview)); // 리스트 형태로 전달
    //     model.addAttribute("hasNext", false); // 의미 없지만 구조 유지
    //     return "review/reviewFrag :: reviewItems";
    // }

    // @GetMapping("/{albumId}/reviews/more")
    // public String loadMoreReviews(@PathVariable("albumId") String albumId,
    //         @RequestParam(name = "page", defaultValue = "1") int page,
    //         @RequestParam(name = "size", defaultValue = "5") int size,
    //         Model model,
    //         @AuthenticationPrincipal CustomUser principal) throws Exception {

    //     List<AlbumReview> allReviews = albumReviewService.getMoreReviews(albumId, page, size);
    //     boolean hasNext = allReviews.size() > size;
    //     List<AlbumReview> reviews = hasNext ? allReviews.subList(0, size) : allReviews;

    //     if (principal != null && !reviews.isEmpty()) {
    //         List<Long> reviewIds = reviews.stream().map(AlbumReview::getId).toList();
    //         List<Long> likedIds = reviewLikeService.getUserLikedReviewIds("ALBUM", reviewIds,
    //                 principal.getUser().getId());
    //         for (AlbumReview r : reviews) {
    //             r.setIsLikedByCurrentUser(likedIds.contains(r.getId()));
    //         }
    //     }

    //     Album album = albumService.select(albumId);

    //     model.addAttribute("hasNext", hasNext);
    //     model.addAttribute("album", album);
    //     model.addAttribute("review", reviews);
    //     model.addAttribute("reviewType", "ALBUM");
    //     model.addAttribute("loginUser", principal != null ? principal.getUser() : null);
    //     model.addAttribute("isAdmin", principal != null && principal.getAuthorities().stream()
    //             .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN")));

    //     return "review/reviewFrag :: reviewItems";
    // }

    // @PostMapping
    // @ResponseBody
    // public ResponseEntity<?> create(@RequestParam("id") String albumId,
    //         @RequestBody @Valid ReviewForm form,
    //         @AuthenticationPrincipal CustomUser user) {
    //     try {
    //         AlbumReview review = albumReviewService.write(albumId, form, user.getUser());
    //         return ResponseEntity.ok(review);
    //     } catch (IllegalStateException e) {
    //         return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 리뷰를 작성했습니다.");
    //     }
    // }

    // @PutMapping("/{id}/review/{reviewId}")
    // @PreAuthorize("@reviewAuth.isAuthorOrAdmin(#p1, 'ALBUM', authentication)")
    // @ResponseBody
    // public ResponseEntity<?> update(@PathVariable("id") String albumId,
    //         @PathVariable("reviewId") Long reviewId,
    //         @RequestBody @Valid ReviewForm form) {
    //     boolean success = albumReviewService.update(reviewId, form);
    //     if (!success) {
    //         return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("수정 실패");
    //     }
    //     AlbumReview updatedReview = albumReviewService.findById(reviewId);
    //     return ResponseEntity.ok(updatedReview);
    // }

    /* ── ③ 삭제 ────────────────────────────── */
    // @DeleteMapping("/{id}/review/{reviewId}")
    // @PreAuthorize("@reviewAuth.isAuthorOrAdmin(#p1, 'ALBUM', authentication)")
    // public String deleteAndRefresh(@PathVariable("id") String albumId,
    //                             @PathVariable("reviewId") Long reviewId,
    //                             Model model) {
    //     albumReviewService.delete(reviewId);
    //     AlbumScore score = albumReviewService.getAlbumScore(albumId);
    //     model.addAttribute("score", score);
    //     return "review/reviewFrag :: reviewSection";  // 리뷰 섹션 프래그먼트 반환
    // }

    // @PostMapping("/album-reviews/{reviewId}/like")
    // @ResponseBody
    // public ResponseEntity<?> toggleReviewLike(@PathVariable("reviewId") Long reviewId,
    //         @AuthenticationPrincipal CustomUser user) {
    //     if (user == null) {
    //         return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
    //     }
    //     reviewLikeService.toggleLike(reviewId, user.getId(), "ALBUM");
    //     int likeCount = reviewLikeService.countLikes(reviewId, "ALBUM");
    //     boolean liked = reviewLikeService.isLiked(reviewId, user.getId(), "ALBUM");
    //     return ResponseEntity.ok(Map.of("likeCount", likeCount, "liked", liked));
    // }

    // @PostMapping("/reviews/{reviewType}/{reviewId}/report")
    // @ResponseBody
    // public ResponseEntity<?> reportReview(@PathVariable("reviewType") String reviewType,
    //         @PathVariable("reviewId") Long reviewId,
    //         @AuthenticationPrincipal CustomUser user) {
    //     if (user == null) {
    //         return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인이 필요합니다.");
    //     }
    //     try {
    //         reviewLikeService.reportReview(reviewId, user.getId(), reviewType);
    //         int reportCount = reviewLikeService.countReports(reviewId, reviewType);
    //         return ResponseEntity.ok(Map.of("reportCount", reportCount));
    //     } catch (IllegalStateException e) {
    //         return ResponseEntity.status(HttpStatus.TOO_MANY_REQUESTS).body("이미 신고한 리뷰입니다.");
    //     }
    // }

    // @PostMapping("/toggle-like")
    // @ResponseBody
    // public ResponseEntity<?> toggleAlbumLike(@RequestBody LikedAlbum dto) throws Exception {
    //     boolean liked = likedAlbumService.toggleLike(dto.getUserId(), dto.getAlbumId());
    //     int count = likedAlbumService.getAlbumLikeCount(dto.getAlbumId());
    //     Map<String, Object> result = new HashMap<>();
    //     result.put("liked", liked);
    //     result.put("count", count);
    //     return ResponseEntity.ok(result);
    // }

    // @PostMapping("/vote")
    // public ResponseEntity<?> saveOrUpdateVote(@RequestBody @Valid ChartElement element,
    //                                     BindingResult bindingResult ) {
    //     if (bindingResult.hasErrors()) {
    //         return ResponseEntity.badRequest().body("입력값 오류");
    //     }
    //     chartElementService.saveOrUpdate(element);
    //     return ResponseEntity.ok().build();
    // }

    // 유저가 투표한 6요소 보여주기
    // @GetMapping("/chart/user")
    // public ResponseEntity<ChartElement> getUserVote(
    //         @RequestParam("userId") Long userId,
    //         @RequestParam("albumId") String albumId) {
    //     ChartElement element = chartElementService.getUserVote(userId, albumId);
    //     return ResponseEntity.ok(element != null ? element : new ChartElement());
    // }

    // 6요소 투표후 6요소 값 반환
    // @GetMapping("/chart/average")
    // public ResponseEntity<Map<String, Integer>> getAverageScores(@RequestParam("albumId") String albumId) {
    //     Map<String, Integer> averages = chartElementService.getAverageScoresByAlbumId(albumId);
    //     return ResponseEntity.ok(averages);
    // }

    /**
     * 비동기 좋아요 한 앨범(키워드 검색)
     *
     * @param data
     * @return
     * @throws Exception
     */
    @PostMapping("/search")
    public ResponseEntity<?> searchMyAlbums(
            @RequestBody Map<String, Object> data) throws Exception {
        Long userId = Long.valueOf(data.get("userId").toString());
        String keyword = data.get("keyword").toString();
        int offset = Integer.parseInt(data.get("offset").toString());
        int limit = Integer.parseInt(data.get("limit").toString());

        List<Album> albumList = albumService.likedAlbums(userId, keyword, offset, limit);
        if (albumList != null)
            return new ResponseEntity<>(albumList, HttpStatus.OK);

        return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);

    }
}
