package com.cosmus.resonos.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ReviewLikeMapper {
    void insertReviewLike(@Param("reviewId") Long reviewId, @Param("userId") Long userId,
                          @Param("reviewType") String reviewType);

    void deleteReviewLike(@Param("reviewId") Long reviewId, @Param("userId") Long userId,
                          @Param("reviewType") String reviewType);

    boolean exists(@Param("reviewId") Long reviewId, @Param("userId") Long userId,
                   @Param("reviewType") String reviewType);

    int countLikes(@Param("reviewId") Long reviewId, @Param("reviewType") String reviewType);

    List<Long> findLikedReviewIds(@Param("reviewType") String reviewType,
                                  @Param("reviewIds") List<Long> reviewIds,
                                  @Param("userId") Long userId);

    Map<Long, Integer> countLikesByReviewIds(@Param("reviewType") String reviewType,
                                             @Param("reviewIds") List<Long> reviewIds);

    void reportReview(@Param("reviewId") Long reviewId, @Param("userId") Long userId,
                      @Param("reviewType") String reviewType);

    int countReports(@Param("reviewId") Long reviewId, @Param("reviewType") String reviewType);
}