package com.cosmus.resonos.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cosmus.resonos.domain.Reviewer;
import com.cosmus.resonos.domain.TrackReview;
import com.cosmus.resonos.domain.TrackScore;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.mapper.TrackReviewMapper;
import com.cosmus.resonos.validation.ReviewForm;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TrackReviewServiceImpl implements TrackReviewService {

    private final TrackReviewMapper mapper;

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
        return mapper.selectPagedReviewsWithReviewer(trackId, size + 1, offset);  // ⭐ 1개 더 가져옴
    }


    public boolean hasNextPage(String trackId, int page, int size) {
        int totalCount = (int)mapper.countByTrackId(trackId);
        int shownCount = page * size; // page=2면 offset=10
        return totalCount > shownCount;
    }



    @Override
    public long countByTrackId(String trackId) {
        return mapper.countByTrackId(trackId);
    }

    @Override
    public List<TrackReview> reviewWithReviewerByUserId(Long loginUserId) throws Exception {
        return mapper.reviewWithReviewerByUserId(loginUserId);
    }
}
