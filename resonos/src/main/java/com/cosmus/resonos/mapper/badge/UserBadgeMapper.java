package com.cosmus.resonos.mapper.badge;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.user.UserBadge;

@Mapper
public interface UserBadgeMapper {
    // 전체 조회
    public List<UserBadge> list() throws Exception;
    // 조회
    public UserBadge select(Long id) throws Exception;
    // 삽입
    public int insert(UserBadge userBadge) throws Exception;
    // 수정
    public int update(UserBadge userBadge) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;

    // 유저 배지 자동 배분
    public List<Long> findBadgeIdsByUserId(@Param("userId") Long userId);
    public void grantBadge(@Param("userId") Long userId, @Param("badgeId") Long badgeId);

    public int grantPostBadgesAll();       // 전체 유저 자동 지급(게시글)
    public int grantCommentBadgesAll();    // 전체 유저 자동 지급(댓글)
    public void grantLikeBadgesAll();       // 전체 유저 자동 지급(좋아요)
    public void grantFollowBadgesAll();     // 전체 유저 자동 지급(팔로우)

    // 유저 배지 확인
    public boolean hasBadge(@Param("userId") Long userId, @Param("badgeId") Long badgeId) throws Exception;
    // 유저 배지 조회
    public UserBadge selectByUserAndBadge(@Param("userId") Long userId, @Param("badgeId") Long badgeId) throws Exception;
    // 유저 배지 목록 조회
    public List<UserBadge> findBadgesByUserId(@Param("userId") Long userId) throws Exception;
    // 유저 배지 삭제
    public int deleteByUserAndBadge(@Param("userId") Long userId, @Param("badgeId") Long badgeId) throws Exception;
    // insertBadgeLog
    public int insertBadgeLog(
        @Param("userId") Long userId,
        @Param("badgeId") Long badgeId,
        @Param("action") String action,
        @Param("actorId") Long actorId,
        @Param("reason") String reason
    ) throws Exception;


    // Map<Long, Long> countByBadge()
    public List<Map<String, Object>> countByBadge() throws Exception;

}
