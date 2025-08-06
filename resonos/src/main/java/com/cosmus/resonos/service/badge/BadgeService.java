package com.cosmus.resonos.service.badge;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.admin.Badge;

public interface BadgeService {
    // 전체 조회
    public List<Badge> list() throws Exception;
    // 조회
    public Badge select(Long id) throws Exception;
    // 삽입
    public boolean insert(Badge badge) throws Exception;
    // 수정
    public boolean update(Badge badge) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;

    /* 마이페이지 */
    // 회득 배지 조회
    public List<Badge> haveBadge(Long loginUserId) throws Exception;
    // 미회득 배지 조회
    public List<Badge> doesNotHaveBadge(Long loginUserId) throws Exception;
    // 배지 소유 여부 체크
    public boolean checkBadge(@Param("loginUserId") Long loginUserId, @Param("badgeId") Long badgeId) throws Exception;
    // 최근 획득 배지
    public List<Badge> recentGetBadge(Long id) throws Exception;
    // 획득 배지 수 조회
    public int badgeCount(Long id) throws Exception;
}
