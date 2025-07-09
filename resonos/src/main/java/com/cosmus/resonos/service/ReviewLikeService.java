package com.cosmus.resonos.service;

import java.util.List;
import java.util.Map;

public interface ReviewLikeService {
    void toggleLike(Long reviewId, Long userId, String reviewType);

    boolean isLiked(Long reviewId, Long userId, String reviewType);

    int countLikes(Long reviewId, String reviewType);

    List<Long> getUserLikedReviewIds(String reviewType, List<Long> reviewIds, Long userId);

    Map<Long, Integer> getLikeCountsByReviewIds(String reviewType, List<Long> reviewIds);

    void reportReview(Long reviewId, Long userId, String reviewType);

    int countReports(Long reviewId, String reviewType);
}