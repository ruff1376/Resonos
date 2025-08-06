package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.Review.RecentReview;

@Mapper
public interface RecentReviewMapper {
    List<RecentReview> findRecentReviewsByArtistId(String artistId);
}
