package com.cosmus.resonos.service;

import java.util.List;

import com.cosmus.resonos.domain.AlbumReview;
import com.cosmus.resonos.domain.AlbumScore;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.validation.ReviewForm;

public interface AlbumReviewService {

    AlbumReview writeReview(AlbumReview review);

    List<AlbumReview> getReviewsForAlbum(String albumId);

    AlbumScore getAlbumScore(String albumId);

    void blindReview(Long id, boolean blinded);

    void like(Long id);

    void dislike(Long id);

    List<AlbumReview> reviewWithReviewerByAlbumId(String albumId);

    AlbumReview write(String albumId, ReviewForm f, Users u);

    boolean update(Long id, ReviewForm form);

    void delete(Long id);

    AlbumReview findById(Long id);

    List<AlbumReview> getMoreReviews(String albumId, int page, int size);

    boolean hasNextPage(String albumId, int page, int size);

    long countByAlbumId(String albumId);

    List<AlbumReview> reviewWithReviewerByUserId(Long loginUserId) throws Exception;
}