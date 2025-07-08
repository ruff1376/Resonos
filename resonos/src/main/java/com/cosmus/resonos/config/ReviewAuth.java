package com.cosmus.resonos.config;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.TrackReview;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.mapper.TrackReviewMapper;

@Component("reviewAuth")
public class ReviewAuth {

    private final TrackReviewMapper trackReviewMapper;

    public ReviewAuth(TrackReviewMapper trackReviewMapper) {
        this.trackReviewMapper = trackReviewMapper;
    }

    public boolean isAuthorOrAdmin(Long reviewId, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return false;
        }
        Object principal = authentication.getPrincipal();
        if (!(principal instanceof CustomUser)) {
            return false;
        }

        CustomUser user = (CustomUser) principal;
        Users currentUser = user.getUser();

        TrackReview review = trackReviewMapper.findById(reviewId);
        if (review == null) {
            return false;
        }

        // 아래 부분 수정: authList에서 ADMIN 권한 찾기
        boolean isAdmin = user.getAuthList().stream()
            .anyMatch(auth -> "ADMIN".equals(auth.getAuth()));

        boolean isAuthor = currentUser.getId().equals(review.getUserId());

        return isAdmin || isAuthor;
    }
}
