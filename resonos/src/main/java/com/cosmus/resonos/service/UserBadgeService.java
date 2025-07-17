package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.UserBadge;

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
    // 유저 배지 배분, 박탈, 확인
    public void giveBadge(Long userId, Long badgeId) throws Exception;   // 수동 지급(중복불가)
    public void revokeBadge(Long userId, Long badgeId) throws Exception; // 회수
    public boolean hasBadge(Long userId, Long badgeId) throws Exception;

    // 유저 배지 자동 배분
    public void grantPostBadges(Long userId) throws Exception;
    public void grantPostBadges() throws Exception;
    public void grantCommentBadges(Long userId) throws Exception;
    public void grantCommentBadges() throws Exception;
}
