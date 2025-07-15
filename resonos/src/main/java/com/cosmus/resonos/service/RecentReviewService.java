package com.cosmus.resonos.service;

import com.cosmus.resonos.domain.RecentReview;
import java.util.List;

public interface RecentReviewService {
    List<RecentReview> getRecentReviewsByArtistId(String artistId);
}
