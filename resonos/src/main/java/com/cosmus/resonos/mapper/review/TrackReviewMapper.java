package com.cosmus.resonos.mapper.review;

import com.cosmus.resonos.domain.Track.TrackReview;
import com.cosmus.resonos.domain.Track.TrackScore;
import com.cosmus.resonos.domain.user.Users;
import com.cosmus.resonos.validation.ReviewForm;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface TrackReviewMapper {

    // ───────── Review CRUD ─────────
    int insert(TrackReview review);
    TrackReview findById(@Param("id") Long id);
    List<TrackReview> findByTrackId(@Param("trackId") String trackId);
    int updateBlindStatus(@Param("id") Long id,@Param("blinded") boolean blinded);
    int incrementLikes(@Param("id") Long id);
    int incrementDislikes(@Param("id") Long id);
    public TrackReview write(String trackId, ReviewForm f, Users u);
    public boolean update(@Param("id") Long id,
                                @Param("rating") Integer rating,
                                @Param("content") String content);
    public void delete(Long id);

    // ───────── Aggregation ─────────
    TrackScore findScoreByTrackId(@Param("trackId") String trackId);

    // 리뷰 + 리뷰어
    List<TrackReview> reviewWithReviewerByTrackId(@Param("trackId") String trackId);

    // 중복 방지
    boolean existsByUserAndTrack(@Param("userId") Long userId, @Param("trackId") String trackId);

    long countByTrackId(String trackId); // 총 개수

    // 리뷰등록시 비동기반환
    TrackReview getLastestReview(@Param("trackId")String trackId, @Param("userId") Long userId);

    List<TrackReview> selectPagedReviewsWithReviewer(@Param("trackId") String trackId,
                                                    @Param("size") int size,
                                                    @Param("offset") int offset);

    /* 마이페이지 */
    // 특정 유저의 리뷰
    public List<TrackReview> reviewWithReviewerByUserId(@Param("loginUserId") Long loginUserId, @Param("keyword") String keyword, @Param("offset") int offset, @Param("limit") int limit) throws Exception;
    // 특정 유저의 리뷰 수
    public int countTrackReview(@Param("loginUserId") Long loginUserId) throws Exception;
    // 특정 유저의 좋아요 한 리뷰 정보
    public List<TrackReview> likedReviewByUserId(@Param("loginUserId") Long loginUserId, @Param("keyword") String keyword, @Param("offset") int offset, @Param("limit") int limit) throws Exception;
    // 특정 유저의 좋아요 한 리뷰 수
    public int countLikedTrackReview(@Param("loginUserId") Long loginUserId) throws Exception;

    // 리뷰 countall
    public long countAll() throws Exception;

    // 리뷰 몇 번째인지
    public int findMyReview(@Param("reviewId") Long reviewId) throws Exception;
}
