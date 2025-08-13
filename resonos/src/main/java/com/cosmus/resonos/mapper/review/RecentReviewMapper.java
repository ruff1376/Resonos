package com.cosmus.resonos.mapper.review;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.review.RecentReview;

@Mapper
public interface RecentReviewMapper {
    List<RecentReview> findRecentReviewsByArtistId(String artistId);
}
