package com.cosmus.resonos.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cosmus.resonos.domain.Reviewer;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.domain.TrackReview;
import com.cosmus.resonos.domain.TrackScore;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.mapper.TrackMapper;
import com.cosmus.resonos.mapper.TrackReviewMapper;
import com.cosmus.resonos.mapper.UserMapper;
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
    @Override
    @Transactional
    public TrackReview writeReview(TrackReview review) {
        if (review.getRating() < 0 || review.getRating() > 100) {
            throw new IllegalArgumentException("rating must be 0~100");
        }
        review.setCreatedAt(LocalDateTime.now());
        review.setBlinded(false);
        review.setLikes(0);
        review.setDislikes(0);
        mapper.insert(review);

        // 1. 트랙 소유자(아티스트) ID
        Track track = trackMapper.selectById(review.getTrackId());        // 아티스트 ID가 String이므로 Long으로 변환
        // Long ownerId = Long.valueOf(track.getArtistId());
        // Long ownerId = track.getArtistId(); // 임시로 변환
        Long ownerId = Long.valueOf(track.getArtistId());
        

        // 2. 리뷰 작성자 닉네임
        Users reviewer = userMapper.selectById(review.getUserId());
        String reviewerName = reviewer.getNickname();

        // 3. 리뷰 대상 타입 및 ID
        String targetType = "트랙";
        String targetId = review.getTrackId();

        // 4. 알림 전송
        notificationService.createNotification(
            ownerId,
            "review",
            "새 리뷰가 작성되었습니다.",
            reviewerName + "님이 " + targetType + "에 리뷰를 남겼습니다.",
            targetId
        );

        return review;
    }


    

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
    public TrackReview write(String trackId, ReviewForm f, Users u){
        // 중복 확인
        boolean exists = mapper.existsByUserAndTrack(u.getId(), trackId);
        if (exists) {
            throw new IllegalStateException("이미 해당 트랙에 리뷰를 작성하셨습니다.");
        }
        System.out.println("작성자 ID: " + u.getId());
        System.out.println("작성자 isPro: " + u.isPro());
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

    @Transactional
    public boolean update(Long id, ReviewForm form){
        return mapper.update(id, form.getRating(), form.getContent());
    }

    @Transactional
    public void delete(Long id){ mapper.delete(id); }


    @Override
    public TrackReview findById(Long id) {
        return mapper.findById(id);
    }


    @Override
    public List<TrackReview> getMoreReviews(String trackId, int page, int size) {
        int offset = (page - 1) * size;
        return mapper.selectPagedReviewsWithReviewer(trackId, size, offset);
    }


    @Override
    public long countByTrackId(String trackId) {
        return mapper.countByTrackId(trackId);
    }
}
