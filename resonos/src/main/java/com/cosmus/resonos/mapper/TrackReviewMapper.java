package com.cosmus.resonos.mapper;

import com.cosmus.resonos.domain.TrackReview;
import com.cosmus.resonos.domain.TrackScore;

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
    
    // ───────── Aggregation ─────────
    TrackScore findScoreByTrackId(@Param("trackId") String trackId);
    
    // 리뷰 + 리뷰어
    List<TrackReview> reviewWithReviewerByTrackId(@Param("trackId") String trackId);
}