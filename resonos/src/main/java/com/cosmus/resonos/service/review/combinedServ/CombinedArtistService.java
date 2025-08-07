package com.cosmus.resonos.service.review.combinedServ;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.review.ArtistMoodVote;
import com.cosmus.resonos.domain.review.MoodStat;
import com.cosmus.resonos.domain.review.RecentReview;
import com.cosmus.resonos.domain.review.responseDTO.ArtistPageDTO;
import com.cosmus.resonos.service.admin.TagService;
import com.cosmus.resonos.service.review.AlbumService;
import com.cosmus.resonos.service.review.ArtistMoodVoteService;
import com.cosmus.resonos.service.review.ArtistService;
import com.cosmus.resonos.service.review.MoodStatService;
import com.cosmus.resonos.service.review.RecentReviewService;
import com.cosmus.resonos.service.review.TrackService;
import com.cosmus.resonos.service.user.ArtistFollowService;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class CombinedArtistService {

    private final ArtistService artistService;
    private final AlbumService albumService;
    private final TrackService trackService;
    private final ArtistFollowService artistFollowService;
    private final ArtistMoodVoteService artistMoodVoteService;
    private final MoodStatService moodStatService;
    private final TagService tagService;
    private final RecentReviewService recentReviewService;
    

    // ArtistPageDTO
    public ResponseEntity<?> artistPageGet(String ArtistId, Long UserId) {

        ArtistPageDTO ArtistPageDTO = new ArtistPageDTO();
        try {
            // 아티스트 기본 정보
            ArtistPageDTO.setArtist(artistService.selectById(ArtistId));
            // 아티스트 해당 유저가 아티스트 팔로우 여부
            ArtistPageDTO.setArtistFollowed(artistFollowService.isLikedByUser(UserId, ArtistId));
            // 아티스트의 팔로우 수
            ArtistPageDTO.setFollowCount(artistFollowService.getArtistFollowCount(ArtistId));
            // 아티스트의 앨범 정보
            ArtistPageDTO.setAlbums(albumService.findAlbumsByArtistId(ArtistId));
            // 아티스트의 앨범 수
            ArtistPageDTO.setAlbumCount(albumService.countAlbumsByArtist(ArtistId));
            // 해당 아티스트의 트랙 수
            ArtistPageDTO.setTrackCount(trackService.countTracksByArtist(ArtistId));
            // 해당 아티스트의 인기곡 상위 7개
            ArtistPageDTO.setTop7Tracks(trackService.selectTop7TracksByArtistAndFetchMv(ArtistId));
            // 해당 아티스트의 제일 인기곡
            ArtistPageDTO.setTrack(ArtistPageDTO.getTop7Tracks().get(0));
            // 아티스트의 분위기 투표 상위 6개
            ArtistPageDTO.setMoodStats(moodStatService.getTop6MoodsByArtistId(ArtistId));
            // 아티스트의 분위기 투표 존재 여부
            if (ArtistPageDTO.getMoodStats() != null) {
                // 그 다음 비어 있는지 확인
                ArtistPageDTO.setMoodEmpty(ArtistPageDTO.getMoodStats().isEmpty());
            } else {
                // null이면 비어있다고 간주
                ArtistPageDTO.setMoodEmpty(true);
            }

            // 아티스트 분위기 투표가 비어있지않으면
            if ( !ArtistPageDTO.isMoodEmpty() ) {
                // 아티스트 분위기 투표했을시 분위기 id
                ArtistPageDTO.setUserVotedMoodId(artistMoodVoteService.getUserVotedMoodId(UserId, ArtistId));
                List<String> moodLabels = ArtistPageDTO.getMoodStats().stream().map(MoodStat::getMoodName).toList();
                List<Integer> moodValues = ArtistPageDTO.getMoodStats().stream().map(MoodStat::getVoteCount).toList();
                ArtistPageDTO.setMoodLabels(moodLabels);
                ArtistPageDTO.setMoodValues(moodValues);
            }
            // 모든 태그정보
            ArtistPageDTO.setAllTags(tagService.list());

            // 아티스트의 최근 리뷰
            List<RecentReview> recentReviews = recentReviewService.getRecentReviewsByArtistId(ArtistId);
            if (!recentReviews.isEmpty() || recentReviews != null) {
                ArtistPageDTO.setRecentReviews(recentReviews);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return ResponseEntity.ok(ArtistPageDTO);
    }

    // 아티스트 페이지 좋아요 토글
    public ResponseEntity<?> toggleArtistLike(Long userId, String artistId) {

        if(userId == null) {
            return new ResponseEntity<>("User is null", HttpStatus.UNAUTHORIZED);
        } else {
            // ArtistFollow artistFollow = new ArtistFollow();
            // artistFollow.setUserId(userId);
            // artistFollow.setArtistId(artistId);
            try {
                // 팔로우여부 확인 후에 현재 팔로우 카운트 가져옴
                boolean followed = artistFollowService.toggleLike(userId, artistId);
                Integer count = artistFollowService.getArtistFollowCount(artistId);
                Map<String, Object> result = new HashMap<>();
                result.put("followed", followed);
                result.put("count", count);
                return new ResponseEntity<>(result, HttpStatus.OK);
            } catch (Exception e) {
                e.printStackTrace();
                return new ResponseEntity<>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
            }
            
        }
        
    }

    // 아티스트 분위기 투표
    public ResponseEntity<?> voteMood(ArtistMoodVote request) {
        // 로그인 안했을때
        if(request.getUserId() == null) {
            return new ResponseEntity<>("User is null", HttpStatus.UNAUTHORIZED);
        }
        // 내부오류
        if (request.getArtistId() == null || request.getMood() == null) {
            return new ResponseEntity<>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
        }
        else {
            // 첫투표 혹은 수정
            artistMoodVoteService.saveOrUpdateVote(request.getUserId(), request.getArtistId(), request.getMood());
            // 자신이 투표한 분위기 아이디 가져오기
            Long votedMoodId = artistMoodVoteService.getUserVotedMoodId(request.getUserId(), request.getArtistId());
            // 분위기 새로 가져오기
            List<MoodStat> moodStats = moodStatService.getTop6MoodsByArtistId(request.getArtistId());
            List<String> moodLabels = moodStats.stream().map(MoodStat::getMoodName).toList();
            List<Integer> moodValues = moodStats.stream().map(MoodStat::getVoteCount).toList();
            Map<String, Object> response = new HashMap<>();
            try {
                response.put("votedMoodId", votedMoodId);
                response.put("labels", moodLabels);
                response.put("values", moodValues);
                response.put("moods", tagService.list());
                return ResponseEntity.ok(response);
            } catch (Exception e) {
                e.printStackTrace();
                return new ResponseEntity<>("FAIL", HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
    }

}
