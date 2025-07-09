package com.cosmus.resonos.config;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.TrackReview;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.mapper.TrackReviewMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component("reviewAuth")
public class ReviewAuth {

    private final TrackReviewMapper trackReviewMapper;

    public ReviewAuth(TrackReviewMapper trackReviewMapper) {
        this.trackReviewMapper = trackReviewMapper;
    }

    public boolean isAuthorOrAdmin(Long reviewId, Authentication authentication) {
        log.info(">>> 인가 확인 시작: reviewId={}, authentication={}", reviewId, authentication);

        if (authentication == null || !authentication.isAuthenticated()) {
            log.warn(">>> 인증되지 않음");
            return false;
        }

        Object principal = authentication.getPrincipal();
        if (!(principal instanceof CustomUser)) {
            log.warn(">>> principal이 CustomUser 아님: {}", principal);
            return false;
        }

        CustomUser user = (CustomUser) principal;
        Users currentUser = user.getUser();
        TrackReview review = trackReviewMapper.findById(reviewId);

        if (review == null) {
            log.warn(">>> review가 null임: id={}", reviewId);
            return false;
        }

        boolean isAdmin = user.isAdmin();
        boolean isAuthor = currentUser.getId().equals(review.getUserId());

        log.info(">>> 인가 결과: isAdmin={}, isAuthor={}", isAdmin, isAuthor);
        return isAdmin || isAuthor;
    }
}
