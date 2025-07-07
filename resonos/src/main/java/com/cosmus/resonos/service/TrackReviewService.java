package com.cosmus.resonos.service;

import java.util.List;

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
}