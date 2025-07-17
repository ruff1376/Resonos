package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.UserBadge;

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

    public void grantPostBadgesAll();       // 전체 유저 자동 지급(게시글)
    public void grantCommentBadgesAll();    // 전체 유저 자동 지급(댓글)
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
    
}
