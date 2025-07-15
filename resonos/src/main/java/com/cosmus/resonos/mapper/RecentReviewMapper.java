package com.cosmus.resonos.mapper;

import com.cosmus.resonos.domain.RecentReview;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RecentReviewMapper {
    List<RecentReview> findRecentReviewsByArtistId(String artistId);
}
