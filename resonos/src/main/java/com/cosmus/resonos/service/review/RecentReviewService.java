package com.cosmus.resonos.service.review;

import java.util.List;

import com.cosmus.resonos.domain.Review.RecentReview;

public interface RecentReviewService {
    List<RecentReview> getRecentReviewsByArtistId(String artistId);
}
