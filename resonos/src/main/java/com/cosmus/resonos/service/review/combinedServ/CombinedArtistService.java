package com.cosmus.resonos.service.review.combinedServ;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

@Service
public class CombinedArtistService {

    @Autowired
    private ArtistService artistService;
    @Autowired
    private AlbumService albumService;
    @Autowired
    private TrackService trackService;
    @Autowired
    private ArtistFollowService artistFollowService;
    @Autowired
    private ArtistMoodVoteService artistMoodVoteService;
    @Autowired
    private MoodStatService moodStatService;
    @Autowired
    private TagService tagService;
    @Autowired
    private RecentReviewService recentReviewService;

    // ArtistPageDTO
    public ArtistPageDTO artistPageGet(String ArtistId, Long UserId) {

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
        }

        return ArtistPageDTO;
    }

    // 아티스트 페이지 좋아요 토글
    public Map<String,Object> toggleArtistLike(Long userId, String artistId) {
        // TODO : 여기부터
        return null;
    }

}
