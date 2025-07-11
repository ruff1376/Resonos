package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.Badge;

@Mapper
public interface BadgeMapper {
    // 전체 조회
    public List<Badge> list() throws Exception;
    // 조회
    public Badge select(Long id) throws Exception;
    // 삽입
    public int insert(Badge badge) throws Exception;
    // 수정
    public int update(Badge badge) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;

    /* 마이페이지 */
    // 회득 배지 조회
    public List<Badge> haveBadge(@Param("loginUserId") Long loginUserId) throws Exception;
    // 미회득 배지 조회
    public List<Badge> doesNotHaveBadge(@Param("loginUserId") Long loginUserId) throws Exception;
    // 배지 소유 여부 체크
    public int checkBadge(@Param("loginUserId") Long loginUserId, @Param("badgeId") Long badgeId) throws Exception;
    // 최근 획득 배지
    public List<Badge> recentGetBadge(@Param("id") Long id) throws Exception;
    // 획득 배지 수 조회
    public int badgeCount(@Param("id") Long id) throws Exception;
}

