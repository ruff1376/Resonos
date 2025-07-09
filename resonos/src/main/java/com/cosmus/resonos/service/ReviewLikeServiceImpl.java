package com.cosmus.resonos.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.cosmus.resonos.mapper.ReviewLikeMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewLikeServiceImpl implements ReviewLikeService {
    private final ReviewLikeMapper mapper;

    @Override
    public void toggleLike(Long reviewId, Long userId, String reviewType) {
        if (mapper.exists(reviewId, userId, reviewType)) {
            mapper.deleteReviewLike(reviewId, userId, reviewType);
        } else {
            mapper.insertReviewLike(reviewId, userId, reviewType);
        }
    }

    @Override
    public boolean isLiked(Long reviewId, Long userId, String reviewType) {
        return mapper.exists(reviewId, userId, reviewType);
    }

    @Override
    public int countLikes(Long reviewId, String reviewType) {
        return mapper.countLikes(reviewId, reviewType);
    }

    @Override
    public List<Long> getUserLikedReviewIds(String reviewType, List<Long> reviewIds, Long userId) {
        return mapper.findLikedReviewIds(reviewType, reviewIds, userId);
    }

    @Override
    public Map<Long, Integer> getLikeCountsByReviewIds(String reviewType, List<Long> reviewIds) {
        return mapper.countLikesByReviewIds(reviewType, reviewIds);
    }

    @Override
    public void reportReview(Long reviewId, Long userId, String reviewType) {
        mapper.reportReview(reviewId, userId, reviewType);
    }

    @Override
    public int countReports(Long reviewId, String reviewType) {
        return mapper.countReports(reviewId, reviewType);
    }
}