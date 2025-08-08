package com.cosmus.resonos.mapper.review;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.review.Album;
import com.cosmus.resonos.domain.review.AlbumReview;
import com.cosmus.resonos.domain.review.AlbumScore;
import com.cosmus.resonos.domain.review.ReviewReport;

@Mapper
public interface AlbumReviewMapper {

    AlbumReview findById(Long id);

    void insert(AlbumReview review);

    List<AlbumReview> findByAlbumId(String albumId);

    List<AlbumReview> reviewWithReviewerByAlbumId(String albumId);

    List<AlbumReview> selectPagedReviewsWithReviewer(@Param("albumId") String albumId,
                                                     @Param("size") int size,
                                                     @Param("offset") int offset);

    // 유저의 앨범 리뷰 조회
    public List<AlbumReview> reviewWithReviewerByUserId(@Param("loginUserId") Long loginUserId, @Param("keyword") String keyword, @Param("offset") int offset, @Param("limit") int limit) throws Exception;
    // 유저의 앨범 리뷰 수
    public int countAlbumReview(@Param("loginUserId") Long loginUserId) throws Exception;
    // 유저의 좋아요 한 앨범 리뷰 조회
    public List<AlbumReview> likedReviewByUserId(@Param("loginUserId") Long loginUserId,  @Param("keyword") String keyword, @Param("offset") int offset, @Param("limit") int limit) throws Exception;
    // 유저의 좋아요 한 앨범 리뷰 수
    public int countLikedAlbumReview(@Param("loginUserId") Long loginUserId) throws Exception;

    void updateBlindStatus(@Param("id") Long id, @Param("blinded") boolean blinded);

    void incrementLikes(Long id);

    void incrementDislikes(Long id);

    AlbumReview getLastestReview(@Param("albumId")String albumId, @Param("userId") Long userId);

    AlbumScore findScoreByAlbumId(String albumId);

    void update(AlbumReview review);

    int delete(Long id);

    boolean existsByUserAndAlbum(@Param("userId") Long userId, @Param("albumId") String albumId);

    long countByAlbumId(String albumId);

    public long countAll() throws Exception;
    public     List<AlbumReview> findAllReviewsWithReviewer();

    // 리뷰 몇 번째인지
    public int findMyReview(@Param("reviewId") Long reviewId) throws Exception;

}
