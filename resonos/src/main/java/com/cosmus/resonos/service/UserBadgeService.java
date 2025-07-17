package com.cosmus.resonos.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.UserBadge;
import com.cosmus.resonos.domain.UserBadgeLog;

public interface UserBadgeService {
    // 전체 조회
    public List<UserBadge> list() throws Exception;
    // 조회
    public UserBadge select(Long id) throws Exception;
    // 삽입
    public boolean insert(UserBadge userBadge) throws Exception;
    // 수정
    public boolean update(UserBadge userBadge) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
    // 유저 배지 배분, 박탈, 확인 - 관리자 수기 
    public void giveBadge(@Param("userId") Long userId, @Param("badgeId") Long badgeId) throws Exception;   // 수동 지급(중복불가)
    public void revokeBadge(@Param("userId") Long userId, @Param("badgeId") Long badgeId) throws Exception; // 회수
    public boolean hasBadge(@Param("userId") Long userId, @Param("badgeId") Long badgeId) throws Exception;

    // 유저 배지 자동 배분
    public void grantPostBadges(@Param("userId") Long userId) throws Exception;
    public void grantCommentBadges(@Param("userId") Long userId) throws Exception;

    // 유저 배지 자동 배분 - 관리자
    public int grantPostBadges() throws Exception;
    public int grantCommentBadges() throws Exception;

    // 로그 전체 또는 필터조회
    public List<UserBadgeLog> getLog(@Param("userId") Long userId,@Param("badgeId") Long badgeId);
    public void addLog(@Param("userId") Long userId, @Param("badgeId") Long badgeId, @Param("action") String action, @Param("actorId") Long actorId, @Param("reason") String reason);
    public Map<Long, Long> countByBadge() throws Exception;
    public List<UserBadge> listByBadge(Long badgeId) throws Exception;
    public List<UserBadge> listByUser(Long userId) throws Exception;

}
