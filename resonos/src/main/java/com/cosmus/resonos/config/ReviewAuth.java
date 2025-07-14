package com.cosmus.resonos.config;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

import com.cosmus.resonos.domain.*;
import com.cosmus.resonos.mapper.AlbumReviewMapper;
import com.cosmus.resonos.mapper.TrackReviewMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component("reviewAuth")
public class ReviewAuth {

    private final TrackReviewMapper trackReviewMapper;
    private final AlbumReviewMapper albumReviewMapper;

    public ReviewAuth(TrackReviewMapper trackReviewMapper, AlbumReviewMapper albumReviewMapper) {
        this.trackReviewMapper = trackReviewMapper;
        this.albumReviewMapper = albumReviewMapper;
    }

    /**
     * 트랙/앨범 리뷰 인가 확인
     * @param reviewId 리뷰 ID
     * @param reviewType "TRACK" 또는 "ALBUM"
     * @param authentication 인증 정보
     * @return 작성자이거나 관리자이면 true
     */
    public boolean isAuthorOrAdmin(Long reviewId, String reviewType, Authentication authentication) {
        log.info(">>> 인가 확인 시작: reviewId={}, reviewType={}, authentication={}", reviewId, reviewType, authentication);

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

        // 리뷰 찾기
        Long authorId = null;
        if ("TRACK".equalsIgnoreCase(reviewType)) {
            TrackReview review = trackReviewMapper.findById(reviewId);
            if (review == null) {
                log.warn(">>> 트랙 리뷰가 null임: id={}", reviewId);
                return false;
            }
            authorId = review.getUserId();
        } else if ("ALBUM".equalsIgnoreCase(reviewType)) {
            AlbumReview review = albumReviewMapper.findById(reviewId);
            if (review == null) {
                log.warn(">>> 앨범 리뷰가 null임: id={}", reviewId);
                return false;
            }
            authorId = review.getUserId();
        } else {
            log.warn(">>> 알 수 없는 reviewType: {}", reviewType);
            return false;
        }

        boolean isAdmin = user.isAdmin();
        boolean isAuthor = currentUser.getId().equals(authorId);

        log.info(">>> 인가 결과: isAdmin={}, isAuthor={}", isAdmin, isAuthor);
        return isAdmin || isAuthor;
    }
}
