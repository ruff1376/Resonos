package com.cosmus.resonos.service.review;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cosmus.resonos.domain.review.Reviewer;
import com.cosmus.resonos.domain.review.TrackReview;
import com.cosmus.resonos.domain.review.TrackScore;
import com.cosmus.resonos.domain.user.Users;
import com.cosmus.resonos.mapper.review.TrackMapper;
import com.cosmus.resonos.mapper.review.TrackReviewMapper;
import com.cosmus.resonos.mapper.user.UserMapper;
import com.cosmus.resonos.service.admin.NotificationService;
import com.cosmus.resonos.validation.ReviewForm;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TrackReviewServiceImpl implements TrackReviewService {

    private final TrackReviewMapper mapper;

    @Autowired
    private NotificationService notificationService;
    @Autowired
    private TrackMapper trackMapper;
    @Autowired
    private UserMapper userMapper;

    /**
     * 평점(0~100) 유효성 검증 후 저장
     */
    // @Override
    // @Transactional
    // public TrackReview writeReview(TrackReview review) {
    // if (review.getRating() < 0 || review.getRating() > 100) {
    // throw new IllegalArgumentException("rating must be 0~100");
    // }
    // review.setCreatedAt(LocalDateTime.now());
    // review.setBlinded(false);
    // review.setLikes(0);
    // review.setDislikes(0);
    // mapper.insert(review);

    // // 1. 트랙 소유자(아티스트) ID
    // Track track = trackMapper.selectById(review.getTrackId()); // 아티스트 ID가
    // String이므로 Long으로 변환
    // // Long ownerId = Long.valueOf(track.getArtistId());
    // // Long ownerId = track.getArtistId(); // 임시로 변환
    // Long ownerId = Long.valueOf(track.getArtistId());

    // // 2. 리뷰 작성자 닉네임
    // Users reviewer = userMapper.selectById(review.getUserId());
    // String reviewerName = reviewer.getNickname();

    // // 3. 리뷰 대상 타입 및 ID
    // String targetType = "트랙";
    // String targetId = review.getTrackId();

    // // 4. 알림 전송
    // notificationService.createNotification(
    // ownerId,
    // "review",
    // "새 리뷰가 작성되었습니다.",
    // reviewerName + "님이 " + targetType + "에 리뷰를 남겼습니다.",
    // targetId
    // );

    // return review;
    // }

    @Override
    public List<TrackReview> getReviewsForTrack(String trackId) {
        return mapper.findByTrackId(trackId);
    }

    @Override
    public TrackScore getTrackScore(String trackId) {
        return mapper.findScoreByTrackId(trackId);
    }

    @Override
    @Transactional
    public void blindReview(Long id, boolean blinded) {
        mapper.updateBlindStatus(id, blinded);
    }

    @Override
    @Transactional
    public void like(Long id) {
        mapper.incrementLikes(id);
    }

    @Override
    @Transactional
    public void dislike(Long id) {
        mapper.incrementDislikes(id);
    }

    @Override
    public List<TrackReview> reviewWithReviewerByTrackId(String trackId) {
        return mapper.reviewWithReviewerByTrackId(trackId);
    }

    @Transactional
    public TrackReview write(String trackId, ReviewForm f, Users u) {
        if(f.getRating() >= 0 && f.getRating() <= 100 && f.getContent() != null){
            TrackReview r = TrackReview.builder()
                    .trackId(trackId)
                    .userId(u.getId())
                    .critic(u.isPro())
                    .rating(f.getRating())
                    .content(f.getContent())
                    .blinded(false)
                    .likes(0).dislikes(0)
                    .createdAt(LocalDateTime.now())
                    .reviewer(new Reviewer(u.getId(), u.getNickname(), u.getProfileImage(), u.isPro()))
                    .build();
            mapper.insert(r);
            return r;
        }
        else return null;
    }

    @Transactional
    public boolean update(Long id, ReviewForm form) {
        // form 의 rating가 0~100점 사이인지 content가 null 이아니라면 수행
        if(form.getRating() >= 0 && form.getRating() <= 100 && form.getContent() != null) {
            return mapper.update(id, form.getRating(), form.getContent());
        }
        else return false;
    }

    @Transactional
    public boolean delete(Long id) {
        return mapper.delete(id) > 0;
    }

    @Override
    public TrackReview findById(Long id) {
        return mapper.findById(id);
    }

    @Override
    public List<TrackReview> getMoreReviews(String trackId, int page, int size) {
        int offset = (page - 1) * size;
        List<TrackReview> reviews = mapper.selectPagedReviewsWithReviewer(trackId, size + 1, offset);
        for (TrackReview review : reviews) {
            if (review.getBlinded() == false) {
                if (review.getDislikes() > 5) {
                    review.setBlinded(true);
                    mapper.updateBlindStatus(review.getId(), true);
                }
            }
        }
        return reviews; // ⭐ 1개 더 가져옴
    }

    public boolean hasNextPage(String trackId, int page, int size) {
        int totalCount = (int) mapper.countByTrackId(trackId);
        int shownCount = page * size; // page=2면 offset=10
        return totalCount > shownCount;
    }

    @Override
    public long countByTrackId(String trackId) {
        return mapper.countByTrackId(trackId);
    }

    @Override
    public List<TrackReview> reviewWithReviewerByUserId(Long loginUserId, String keyword, int offset, int limit)
            throws Exception {
        return mapper.reviewWithReviewerByUserId(loginUserId, keyword, offset, limit);
    }

    @Override
    public int countTrackReview(Long loginUserId) throws Exception {
        return mapper.countTrackReview(loginUserId);
    }

    @Override
    public List<TrackReview> likedReviewByUserId(Long loginUserId, String keyword, int offset, int limit)
            throws Exception {
        return mapper.likedReviewByUserId(loginUserId, keyword, offset, limit);
    }

    @Override
    public int countLikedTrackReview(Long loginUserId) throws Exception {
        return mapper.countLikedTrackReview(loginUserId);
    }

    @Override
    public TrackReview writeReview(TrackReview review) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'writeReview'");
    }

    @Override
    public TrackReview getLastestReview(String trackId, Long userId) {
        return mapper.getLastestReview(trackId, userId);
    }

    @Override
    public long countAll() throws Exception {
        return mapper.countAll();
    }

    @Override
    public int findMyReview(Long reviewId) throws Exception {
        return mapper.findMyReview(reviewId);
    }
}
