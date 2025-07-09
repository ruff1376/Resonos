package com.cosmus.resonos.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.TrackReview;
import com.cosmus.resonos.domain.TrackScore;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.validation.ReviewForm;

@Service
public interface TrackReviewService {
    TrackReview writeReview(TrackReview review);
    List<TrackReview> getReviewsForTrack(String trackId);
    TrackScore getTrackScore(String trackId);
    void blindReview(Long id, boolean blinded);
    void like(Long id);
    void dislike(Long id);
    public TrackReview write(String trackId, ReviewForm f, Users u);
    public boolean update(Long reviewId, ReviewForm form);
    public void delete(Long id);
    TrackReview findById(Long id);

    // 리뷰 + 리뷰어
    List<TrackReview> reviewWithReviewerByTrackId(@Param("trackId") String trackId);
}