package com.cosmus.resonos.mapper;

import com.cosmus.resonos.domain.TrackReview;
import com.cosmus.resonos.domain.TrackScore;
import com.cosmus.resonos.domain.Users;
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

    List<TrackReview> selectPagedReviewsWithReviewer(@Param("trackId") String trackId,
                                                    @Param("size") int size,
                                                    @Param("offset") int offset);

}