package com.cosmus.resonos.service.review;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cosmus.resonos.domain.review.Album;
import com.cosmus.resonos.domain.review.AlbumReview;
import com.cosmus.resonos.domain.review.AlbumScore;
import com.cosmus.resonos.domain.review.Reviewer;
import com.cosmus.resonos.domain.review.TrackReview;
import com.cosmus.resonos.domain.user.Users;
import com.cosmus.resonos.mapper.review.AlbumReviewMapper;
import com.cosmus.resonos.validation.ReviewForm;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
class AlbumReviewServiceImpl implements AlbumReviewService {

    private final AlbumReviewMapper mapper;

    @Override
    @Transactional
    public AlbumReview writeReview(AlbumReview review) {
        if (review.getRating() < 0 || review.getRating() > 100) {
            throw new IllegalArgumentException("rating must be 0~100");
        }
        review.setCreatedAt(LocalDateTime.now());
        review.setBlinded(false);
        review.setLikes(0);
        review.setDislikes(0);
        mapper.insert(review);
        return review;
    }

    @Override
    public List<AlbumReview> getReviewsForAlbum(String albumId) {
        return mapper.findByAlbumId(albumId);
    }

    @Override
    public AlbumScore getAlbumScore(String albumId) {
        return mapper.findScoreByAlbumId(albumId);
    }

    @Override
    @Transactional
    public void blindReview(Long id, boolean blinded) {
        mapper.updateBlindStatus(id, blinded);
    }

    @Override
    @Transactional
    public void like(Long id) {
        mapper.incrementLikes(id);
    }

    @Override
    @Transactional
    public void dislike(Long id) {
        mapper.incrementDislikes(id);
    }

    @Override
    public List<AlbumReview> reviewWithReviewerByAlbumId(String albumId) {
        return mapper.reviewWithReviewerByAlbumId(albumId);
    }

    @Transactional
    public AlbumReview write(String albumId, ReviewForm f, Users u){
        boolean exists = mapper.existsByUserAndAlbum(u.getId(), albumId);
        if (exists) {
            throw new IllegalStateException("이미 해당 앨범에 리뷰를 작성하셨습니다.");
        }
        AlbumReview r = AlbumReview.builder()
                .albumId(albumId)
                .userId(u.getId())
                .critic(u.isPro())
                .rating(f.getRating())
                .content(f.getContent())
                .blinded(false)
                .likes(0).dislikes(0)
                .createdAt(LocalDateTime.now())
                .reviewer(new Reviewer(u.getId(), u.getNickname(), u.getProfileImage(), u.isPro()))
                .build();
        mapper.insert(r);
        return r;
    }

    @Transactional
    public boolean update(Long id, ReviewForm form){
        AlbumReview review = AlbumReview.builder()
                .id(id)
                .rating(form.getRating())
                .content(form.getContent())
                .build();
        mapper.update(review);
        return true;
    }

    @Transactional
    public boolean delete(Long id){
        return mapper.delete(id) > 0;
    }

    @Override
    public AlbumReview findById(Long id) {
        return mapper.findById(id);
    }

    @Override
    public List<AlbumReview> getMoreReviews(String albumId, int page, int size) {
        int offset = (page - 1) * size;
        List<AlbumReview> reviews = mapper.selectPagedReviewsWithReviewer(albumId, size + 1, offset);
        for (AlbumReview review : reviews) {
            if(review.getBlinded() == false) {
                if( review.getDislikes() > 5 ) {
                    review.setBlinded(true);
                    mapper.updateBlindStatus(review.getId(), true);
                }
            }
        }
        return reviews;
    }

    public boolean hasNextPage(String albumId, int page, int size) {
        int totalCount = (int)mapper.countByAlbumId(albumId);
        int shownCount = page * size;
        return totalCount > shownCount;
    }

    @Override
    public long countByAlbumId(String albumId) {
        return mapper.countByAlbumId(albumId);
    }

    @Override
    public AlbumReview getLastestReview(String albumId, Long userId) {
        return mapper.getLastestReview(albumId, userId);
    }
    @Override
    public long countAll() throws Exception {
        return mapper.countAll();
    }
    @Override
    public List<AlbumReview> getAllReviewsWithReviewer() {
        return mapper.findAllReviewsWithReviewer();
    }

    @Override
    public List<AlbumReview> findAllReviewsWithReviewer() throws Exception {
        throw new UnsupportedOperationException("Unimplemented method 'findAllReviewsWithReviewer'");
    }

    @Override
    public List<AlbumReview> reviewWithReviewerByUserId(Long loginUserId, String keyword, int offset, int limit) throws Exception {
        return mapper.reviewWithReviewerByUserId(loginUserId, keyword, offset, limit);
    }

    @Override
    public int countAlbumReview(Long loginUserId) throws Exception {
        return mapper.countAlbumReview(loginUserId);
    }

    @Override
    public List<AlbumReview> likedReviewByUserId(Long loginUserId, String keyword, int offset, int limit) throws Exception {
        return mapper.likedReviewByUserId(loginUserId, keyword, offset, limit);
    }

    @Override
    public int countLikedAlbumReview(Long loginUserId) throws Exception {
        return mapper.countLikedAlbumReview(loginUserId);
    }

    @Override
    public int findMyReview(Long reviewId) throws Exception {
        return mapper.findMyReview(reviewId);
    }
}
