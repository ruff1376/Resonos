package com.cosmus.resonos.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.TrackReview;
import com.cosmus.resonos.domain.TrackScore;

@Service
public interface TrackReviewService {
    TrackReview writeReview(TrackReview review);
    List<TrackReview> getReviewsForTrack(String trackId);
    TrackScore getTrackScore(String trackId);
    void blindReview(Long id, boolean blinded);
    void like(Long id);
    void dislike(Long id);

    // 리뷰 + 리뷰어
    List<TrackReview> reviewWithReviewerByTrackId(@Param("trackId") String trackId);
}