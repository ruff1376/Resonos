package com.cosmus.resonos.service.review;

import java.util.List;

import com.cosmus.resonos.domain.review.RecentReview;

public interface RecentReviewService {
    List<RecentReview> getRecentReviewsByArtistId(String artistId);
}
