package com.cosmus.resonos.service.review.combinedServ;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.review.AlbumReview;
import com.cosmus.resonos.domain.review.AlbumScore;
import com.cosmus.resonos.domain.review.ChartElement;
import com.cosmus.resonos.domain.review.LikedAlbum;
import com.cosmus.resonos.domain.review.responseDTO.AlbumPageDTO;
import com.cosmus.resonos.domain.user.Users;
import com.cosmus.resonos.service.review.AlbumReviewService;
import com.cosmus.resonos.service.review.AlbumService;
import com.cosmus.resonos.service.review.ArtistService;
import com.cosmus.resonos.service.review.ChartElementService;
import com.cosmus.resonos.service.review.ReviewLikeService;
import com.cosmus.resonos.service.review.TrackService;
import com.cosmus.resonos.service.user.LikedAlbumService;
import com.cosmus.resonos.service.user.PlaylistService;
import com.cosmus.resonos.validation.ReviewForm;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class CombinedAlbumService {

    private final TrackService trackService;
    private final AlbumService albumService;
    private final AlbumReviewService albumReviewService;
    private final ArtistService artistService;
    private final ReviewLikeService reviewLikeService;
    private final LikedAlbumService likedAlbumService;
    private final ChartElementService chartElementService;
    private final PlaylistService playlistService;

    // 앨범 메인페이지
    public ResponseEntity<?> albumInfo(String albumId, CustomUser user) {
        AlbumPageDTO pageDTO = new AlbumPageDTO();
        int page = 1;
        int size = 10;

        try {

            pageDTO.setScore(albumReviewService.getAlbumScore(albumId));
            pageDTO.setTopTrack(trackService.topTrackByAlbumIdAndFetchMv(albumId));
            pageDTO.setAlbum(albumService.select(albumId));
            pageDTO.setArtist(artistService.findArtistByAlbumId(albumId));
            pageDTO.setTracks(trackService.findTracksByAlbumId(albumId));
            pageDTO.setTop5List(trackService.findTop5TracksByAlbumId(albumId));
            pageDTO.setAlbumLikeCount(likedAlbumService.getAlbumLikeCount(albumId));
            if (playlistService.getPlaylistsByAlbumId(albumId) != null) {
                pageDTO.setPlayLists(playlistService.getPlaylistsByAlbumId(albumId));
                pageDTO.setEmptyPlayList( false);
            }
            // 앨범 리뷰 초기 로딩
            List<AlbumReview> reviews = albumReviewService.getMoreReviews(albumId, page, size);
            // 앨범 총 리뷰 갯수
            long totalCount = albumReviewService.countByAlbumId(albumId);
            Pagination pagination = new Pagination(page, size, 10, totalCount);
            pageDTO.setHasNext(pagination.getLast() > page);

            // 유저 정보
            // 유저의 로그인 여부 확인
            Users loginUser = null;
            if (user != null) {
                loginUser = user.getUser();
                // 앨범 좋아요 여부 체크
                pageDTO.setAlbumLikedByUser(likedAlbumService.isLikedByUser(loginUser.getId(), albumId));
                ChartElement userVote = null;
                userVote = chartElementService.getUserVote(loginUser.getId(), albumId);
                pageDTO.setUserVote(userVote);
            }
            // 로그인시 리뷰 좋아요 여부 매핑
            if (loginUser != null && reviews != null && !reviews.isEmpty()) {
                List<Long> reviewIds = reviews.stream().map(AlbumReview::getId).toList();
                List<Long> likedReviewIds = reviewLikeService.getUserLikedReviewIds("ALBUM", reviewIds,
                        loginUser.getId());
                for (AlbumReview review : reviews) {
                    review.setIsLikedByCurrentUser(likedReviewIds.contains(review.getId()));
                    pageDTO.setReviews(reviews);
                }
            }
            Map<String, Integer> chart = chartElementService.getAverageScoresByAlbumId(albumId);
            if(chart != null && !chart.isEmpty()) {
                pageDTO.setArgValues(chartElementService.getAverageScoresByAlbumId(albumId));
                pageDTO.setArgEmpty(false);
            }
            return new ResponseEntity<>(pageDTO, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
        }

        // 리뷰 관련

        // List<AlbumReview> IndexReviews =
        // albumReviewService.reviewWithReviewerByAlbumId(id);
        // // 찾는 리뷰의 순서
        // if (reviewId != null) {
        // int index = IntStream.range(0, IndexReviews.size())
        // .filter(i -> IndexReviews.get(i).getId().equals(reviewId))
        // .findFirst()
        // .orElse(-1);

        // log.info("reviewId가 위치한 인덱스: {}", index);
        // if (index != -1) {
        // size = ((index + 1 - 1) / size + 1) * 5;
        // model.addAttribute("size", size);
        // }
        // }

        // Map<String, Integer> argValues = chartElementService.getAverageScoresByAlbumId(albumId);

        // // 요소 이름 리스트 (순서 고정)
        // List<String> argLabels = Arrays.asList("가사", "사운드", "멜로디", "스토리텔링", "유기성", "독창성");
        // // 요소 점수 리스트
        // List<Integer> argScores = null;
        // if (argValues != null && !argValues.isEmpty()) {
        //     argScores = Arrays.asList(
        //             argValues.getOrDefault("lyric", 0),
        //             argValues.getOrDefault("sound", 0),
        //             argValues.getOrDefault("melody", 0),
        //             argValues.getOrDefault("storytelling", 0),
        //             argValues.getOrDefault("cohesiveness", 0),
        //             argValues.getOrDefault("creativity", 0));
        // }
    }

    // 앨범 좋아요
    public ResponseEntity<?> toggleAlbumLike(LikedAlbum dto) {
        try {
            boolean liked = likedAlbumService.toggleLike(dto.getUserId(), dto.getAlbumId());
            int count = likedAlbumService.getAlbumLikeCount(dto.getAlbumId());
            Map<String, Object> result = new HashMap<>();
            result.put("liked", liked);
            result.put("count", count);
            return ResponseEntity.ok(result);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 앨범 리뷰 작성시 리뷰와 갱신된 점수 반환
    public ResponseEntity<?> albumReviewPost(String albumId, ReviewForm form, CustomUser user) {
        try {
            AlbumReview review = albumReviewService.write(albumId, form, user.getUser());
            AlbumScore score = albumReviewService.getAlbumScore(albumId);
            return new ResponseEntity<>(Map.of("review", review, "score", score), HttpStatus.OK);
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("이미 리뷰를 작성했습니다.");
        }
    }

    // 리뷰 더보기
    // 추후 어드민 관련 로직 추가해야함
    public ResponseEntity<?> loadMoreReviews(String albumId, int page, int size,
                   @AuthenticationPrincipal CustomUser user) {

        Users loginUsers = null;
        if (user != null) {
            loginUsers = user.getUser();
        }

        List<AlbumReview> allReviews = albumReviewService.getMoreReviews(albumId, page, size);
        boolean hasNext = allReviews.size() > size;
        List<AlbumReview> reviews = hasNext ? allReviews.subList(0, size) : allReviews;

        Map<String, Object> reviewMap = new HashMap<>();
        reviewMap.put("hasNext", hasNext);

        if (loginUsers != null && !reviews.isEmpty()) {
            List<Long> reviewIds = reviews.stream().map(AlbumReview::getId).toList();
            List<Long> likedIds = reviewLikeService.getUserLikedReviewIds("ALBUM", reviewIds,
                    loginUsers.getId());
            for (AlbumReview r : reviews) {
                r.setIsLikedByCurrentUser(likedIds.contains(r.getId()));
                List<AlbumReview> review = List.of(r);
                reviewMap.put("review", review);
            }
        }

        return new ResponseEntity<>(reviewMap, HttpStatus.OK);
    }

    // 리뷰 수정
    public ResponseEntity<?> update(String albumId, Long reviewId,
                            ReviewForm form) {
        boolean success = albumReviewService.update(reviewId, form);
        if (!success) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("FAIL");
        }
        AlbumReview updatedReview = albumReviewService.findById(reviewId);
        AlbumScore score = albumReviewService.getAlbumScore(albumId);
        Map<String, Object> result = new HashMap<>();
        result.put("review", updatedReview);
        result.put("score", score);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    // 리뷰 삭제
    public ResponseEntity<?> delete(String albumId, Long reviewId) {
        boolean success = albumReviewService.delete(reviewId);
        if(success) {
            AlbumScore score = albumReviewService.getAlbumScore(albumId);
            return new ResponseEntity<>(score, HttpStatus.OK);
        }
        else return new ResponseEntity<>("FAIL",HttpStatus.INTERNAL_SERVER_ERROR);
    }

    // 리뷰 좋아요
    public ResponseEntity<?> toggleReviewLike(Long reviewId, CustomUser user) {
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User is null");
        }
        reviewLikeService.toggleLike(reviewId, user.getId(), "ALBUM");
        int likeCount = reviewLikeService.countLikes(reviewId, "ALBUM");
        boolean liked = reviewLikeService.isLiked(reviewId, user.getId(), "ALBUM");
        return ResponseEntity.ok(Map.of("likeCount", likeCount, "liked", liked));
    }

    // 리뷰 신고
    public ResponseEntity<?> reportReview(Long reviewId, CustomUser user) {
        if (user == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User is null");
        }
        try {
            reviewLikeService.reportReview(reviewId, user.getId(), "Album");
            int reportCount = reviewLikeService.countReports(reviewId, "Album");
            return ResponseEntity.ok(Map.of("reportCount", reportCount));
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.TOO_MANY_REQUESTS).body("이미 신고한 리뷰입니다.");
        }
    }

    // 6요소 투표
    public ResponseEntity<?> saveOrUpdateVote(String albumId, ChartElement element, CustomUser user ) {
        Users loginUser = null;
        if (user != null) {
            loginUser = user.getUser();
            element.setUserId(loginUser.getId());
            element.setAlbumId(albumId);
            // element 의 albumId 변수를 제외한 모든 값이 0~100 인지 검증
            if (element.getLyric() < 0 || element.getLyric() > 100
                    || element.getSound() < 0 || element.getSound() > 100
                    || element.getMelody() < 0 || element.getMelody() > 100
                    || element.getStorytelling() < 0 || element.getStorytelling() > 100
                    || element.getCohesiveness() < 0 || element.getCohesiveness() > 100
                    || element.getCreativity() < 0 || element.getCreativity() > 100) {
                return ResponseEntity.badRequest().body("입력값 오류");
            }
            chartElementService.saveOrUpdate(element);
            Map<String, Integer> avgArg = chartElementService.getAverageScoresByAlbumId(element.getAlbumId());
            ChartElement userArg = chartElementService.getUserVote(loginUser.getId(), albumId);
            return ResponseEntity.ok(Map.of("avgArg", avgArg,"userArg", userArg));
        }
        else return new ResponseEntity<>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
