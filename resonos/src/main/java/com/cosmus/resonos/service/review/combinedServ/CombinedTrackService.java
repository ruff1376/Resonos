package com.cosmus.resonos.service.review.combinedServ;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.admin.Tag;
import com.cosmus.resonos.domain.review.LikedTrack;
import com.cosmus.resonos.domain.review.MoodStat;
import com.cosmus.resonos.domain.review.TrackMoodVote;
import com.cosmus.resonos.domain.review.TrackReview;
import com.cosmus.resonos.domain.review.TrackScore;
import com.cosmus.resonos.domain.review.responseDTO.TrackPageDTO;
import com.cosmus.resonos.domain.user.Playlist;
import com.cosmus.resonos.mapper.review.TrackReviewMapper;
import com.cosmus.resonos.service.admin.TagService;
import com.cosmus.resonos.service.review.AlbumService;
import com.cosmus.resonos.service.review.ArtistService;
import com.cosmus.resonos.service.review.MoodStatService;
import com.cosmus.resonos.service.review.ReviewLikeService;
import com.cosmus.resonos.service.review.TrackMoodVoteService;
import com.cosmus.resonos.service.review.TrackReviewService;
import com.cosmus.resonos.service.review.TrackService;
import com.cosmus.resonos.service.user.LikedTrackService;
import com.cosmus.resonos.service.user.PlaylistService;
import com.cosmus.resonos.validation.ReviewForm;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class CombinedTrackService {

    private final ArtistService artistService;
    private final AlbumService albumService;
    private final TrackService trackService;
    private final TrackMoodVoteService trackMoodVoteService;
    private final MoodStatService moodStatService;
    private final TagService tagService;
    private final TrackReviewService trackReviewService;
    private final ReviewLikeService reviewLikeService;
    private final LikedTrackService likedTrackService;
    private final PlaylistService playlistService;
    private final TrackReviewMapper trackReviewMapper;

    // TrackPageDTO
    public ResponseEntity<?> trackPage(String trackId, Long userId) {
        TrackPageDTO trackPageDTO = new TrackPageDTO();

        int page = 1;
        int size = 10;

        try {
            // 어드민 여부

            // 트랙 상세 정보
            trackPageDTO.setTrack(trackService.getTrackOrUpdate(trackId));
            // 트랙의 앨범
            trackPageDTO.setAlbum(albumService.findAlbumByTrackId(trackId));
            // 동일 앨범 내 인기 트랙 5개
            trackPageDTO.setTop5List(trackService.findTop5TracksInSameAlbum(trackId));
            // 트랙의 해당 아티스트
            trackPageDTO.setArtist(artistService.selectArtistByTrackId(trackId));
            // 트랙의 평점 정보
            trackPageDTO.setScore(trackReviewService.getTrackScore(trackId));
            // 트랙의 리뷰 초기 로딩
            List<TrackReview> reviews = trackReviewService.getMoreReviews(trackId, page, size);
            // 리뷰들 중에 유저가 좋아요한 리뷰찾아서 좋아요 여부 설정
            if (userId != null && reviews != null && !reviews.isEmpty()) {
                // 리뷰 아이디 들로 리스트 생성
                List<Long> reviewIds = reviews.stream()
                        .map(TrackReview::getId)
                        .collect(Collectors.toList());

                if (!reviewIds.isEmpty()) {
                    // 리뷰아이디로 해당 유저가 좋아요 했을시 좋아요 여부 표시
                    List<Long> likedReviewIds = reviewLikeService.getUserLikedReviewIds("TRACK", reviewIds, userId);
                    reviews.forEach(review -> review.setIsLikedByCurrentUser(likedReviewIds.contains(review.getId())));
                }
                trackPageDTO.setReviews(reviews);
            }
            // 트랙의 리뷰 더보기 여부
            trackPageDTO.setHasNext(trackReviewService.hasNextPage(trackId, page, size));
            // 트랙의 좋아요 수
            trackPageDTO.setTrackLikeCount(likedTrackService.getTrackLikeCount(trackId));
            // 유저의 트랙 좋아요 유무
            trackPageDTO.setTrackLikedByUser(likedTrackService.isLikedByUser(userId, trackId));
            // 트랙이 포함된 재생목록
            List<Playlist> playlists = playlistService.getPlaylistsByTrackId(trackId);
            // 트랙이 포함된 재생목록 유무 확인
            if (playlists.isEmpty() || playlists == null) {
                trackPageDTO.setEmptyPlayList(true);
            } else {
                trackPageDTO.setEmptyPlayList(false);
                trackPageDTO.setPlayLists(playlists);
            }
            // 트랙의 분위기 투표 상위 6개
            trackPageDTO.setMoodStats(moodStatService.getTop6MoodsByTrackId(trackId));
            // 트랙의 분위기 투표 존재 여부
            if (trackPageDTO.getMoodStats() != null) {
                // 그 다음 비어 있는지 확인
                trackPageDTO.setMoodEmpty(trackPageDTO.getMoodStats().isEmpty());
            } else {
                // null이면 비어있다고 간주
                trackPageDTO.setMoodEmpty(true);
            }

            // 트랙의 분위기 투표가 비어있지 않으면
            if (!trackPageDTO.isMoodEmpty()) {
                // 트랙의 분위기 투표했을시 분위기 id
                trackPageDTO.setUserVotedMoodId(trackMoodVoteService.getUserVotedMoodId(userId, trackId));
                trackPageDTO.setMoodLabels(moodStatService.getTop6MoodsByTrackId(trackId).stream()
                        .map(moodStat -> moodStat.getMoodName()).toList());
                trackPageDTO.setMoodValues(moodStatService.getTop6MoodsByTrackId(trackId).stream()
                        .map(moodStat -> moodStat.getVoteCount()).toList());
            }
            // 모든 태그정보
            trackPageDTO.setTags(tagService.list());

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return new ResponseEntity<>(trackPageDTO, HttpStatus.OK);
    }

    // 트랙 리뷰 작성
    public ResponseEntity<?> reviewPost(String trackId, ReviewForm f, CustomUser u) {
        // 중복 확인
        boolean exists = trackReviewMapper.existsByUserAndTrack(u.getId(), trackId);
        if (exists) {
            return new ResponseEntity<>("ALREADY_EXISTS", HttpStatus.TOO_MANY_REQUESTS);
        }
        TrackReview reivew = trackReviewService.write(trackId, f, u.getUser());
        if (reivew != null) {
            return new ResponseEntity<>(reivew, HttpStatus.OK);
        } else
            return new ResponseEntity<>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
    }

    // 트랙 리뷰 수정
    public ResponseEntity<?> reviewUpdate(Long reviewId, ReviewForm f, String trackId) {
        boolean success = trackReviewService.update(reviewId, f);
        if (!success) {
            return new ResponseEntity<>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
        } else {
            Map<String, Object> updatedStatus = new HashMap<>();
            TrackReview updatedReview = trackReviewService.findById(reviewId);
            TrackScore updatedScore = trackReviewService.getTrackScore(trackId);
            updatedStatus.put("updatedReview", updatedReview);
            updatedStatus.put("updatedScore", updatedScore);
            return ResponseEntity.ok(updatedStatus);
        }
    }

    // 트랙 리뷰 삭제
    public ResponseEntity<?> reviewDelete(Long reviewId, String trackId) {
        boolean success = trackReviewService.delete(reviewId);
        if (!success) {
            return new ResponseEntity<>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
        } else {
            TrackScore score = trackReviewService.getTrackScore(trackId);
            return ResponseEntity.ok(score);
        }
    }

    // 트랙 리뷰 좋아요
    public ResponseEntity<?> reviewLike(Long reviewId, CustomUser user) {
        if (user.getUser() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("User is null");
        }
        reviewLikeService.toggleLike(reviewId, user.getId(), "TRACK");

        int likeCount = reviewLikeService.countLikes(reviewId, "TRACK");
        boolean liked = reviewLikeService.isLiked(reviewId, user.getId(), "TRACK");

        return ResponseEntity.ok(Map.of("likeCount", likeCount, "liked", liked));
    }

    // 트랙 리뷰 신고
    public ResponseEntity<?> reportReview(Long reviewId, CustomUser user) {
        if (user.getUser() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("User is null");
        }
        try {
            reviewLikeService.reportReview(reviewId, user.getId(), "TRACK");
            int reportCount = reviewLikeService.countReports(reviewId, "TRACK");
            return new ResponseEntity<>(reportCount, HttpStatus.OK);
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.TOO_MANY_REQUESTS)
                    .body("이미 신고한 리뷰입니다.");
        }
    }

    // 트랙 분위기 투표
    public ResponseEntity<?> voteMood(@RequestBody TrackMoodVote request) {
        // 저장 또는 수정
        trackMoodVoteService.saveOrUpdateVote(request.getUserId(), request.getTrackId(), request.getMood());

        if (request.getUserId() == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("User is null");
        }

        if (request.getTrackId() == null || request.getMood() == null) {
            return ResponseEntity.badRequest().body("FAIL");
        }
        // 응답 데이터 구성
        Long votedMoodId = trackMoodVoteService.getUserVotedMoodId(request.getUserId(), request.getTrackId());
        // 투표 저장 후 최신 mood 데이터 조회
        List<MoodStat> moodStats = moodStatService.getTop6MoodsByTrackId(request.getTrackId());

        Map<String, Object> response = new HashMap<>();
        try {
            List<Tag> tags = tagService.list();
            response.put("moods", tags);
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<String> moodLabels = moodStats.stream()
                .map(MoodStat::getMoodName)
                .collect(Collectors.toList());
        List<Integer> moodValues = moodStats.stream()
                .map(MoodStat::getVoteCount)
                .collect(Collectors.toList());

        response.put("votedMoodId", votedMoodId);
        response.put("labels", moodLabels);
        response.put("values", moodValues);

        return ResponseEntity.ok(response);
    }

    // 트랙 좋아요
    public ResponseEntity<?> toggleTrackLike(LikedTrack dto) {
        try {
            boolean liked = likedTrackService.toggleLike(dto.getUserId(), dto.getTrackId());
            int count = likedTrackService.getTrackLikeCount(dto.getTrackId());
            Map<String, Object> result = new HashMap<>();
            result.put("liked", liked);
            result.put("count", count);
    
            return ResponseEntity.ok(result);
            
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }
}
