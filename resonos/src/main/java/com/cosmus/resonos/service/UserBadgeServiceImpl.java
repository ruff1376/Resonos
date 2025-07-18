package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Badge;
import com.cosmus.resonos.domain.UserBadge;
import com.cosmus.resonos.mapper.BadgeMapper;
import com.cosmus.resonos.mapper.BoardPostMapper;
import com.cosmus.resonos.mapper.CommentMapper;
import com.cosmus.resonos.mapper.UserBadgeMapper;

@Service
public class UserBadgeServiceImpl implements UserBadgeService {

    @Autowired
    private UserBadgeMapper userBadgeMapper;
    @Autowired
    private BadgeConditionService badgeConditionService;
    @Autowired
    private BoardPostMapper boardPostMapper;
    @Autowired
    private CommentMapper commentMapper;
    @Autowired
    private BadgeMapper badgeMapper;
    @Autowired
    private NotificationService notificationService;

    @Override
    public List<UserBadge> list() throws Exception {
        return userBadgeMapper.list();
    }

    @Override
    public UserBadge select(Long id) throws Exception {
        return userBadgeMapper.select(id);
    }

    @Override
    public boolean insert(UserBadge userBadge) throws Exception {
        return userBadgeMapper.insert(userBadge) > 0;
    }

    @Override
    public boolean update(UserBadge userBadge) throws Exception {
        return userBadgeMapper.update(userBadge) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return userBadgeMapper.delete(id) > 0;
    }

    @Override
    public void giveBadge(Long userId, Long badgeId) throws Exception {
        if (!hasBadge(userId, badgeId)) {
            userBadgeMapper.grantBadge(userId, badgeId);

            String badgeName = "";
            Badge badge = badgeMapper.select(badgeId);
            if (badge != null) badgeName = badge.getName();

            notificationService.createNotification(
                userId,
                "badge_grant",
                "새 배지 획득!",
                "축하합니다! [" + badgeName + "] 배지를 획득했습니다.",
                badgeId.toString()
            );
            userBadgeMapper.insertBadgeLog(userId, badgeId, "GRANT", null, "자동·수동 지급");
        }
    }

    @Override
    public void revokeBadge(Long userId, Long badgeId) throws Exception {
        if (hasBadge(userId, badgeId)) {
            userBadgeMapper.deleteByUserAndBadge(userId, badgeId);

            String badgeName = "";
            Badge badge = badgeMapper.select(badgeId);
            if (badge != null) badgeName = badge.getName();

            notificationService.createNotification(
                userId,
                "badge_revoke",
                "배지 회수",
                "[" + badgeName + "] 배지가 회수 또는 만료되었습니다.",
                badgeId.toString()
            );
            userBadgeMapper.insertBadgeLog(userId, badgeId, "REVOKE", null, "배지 회수");
        }
    }

    @Override
    public boolean hasBadge(Long userId, Long badgeId) throws Exception {
        // 빠른 EXISTS 방식으로
        return userBadgeMapper.hasBadge(userId, badgeId);
    }

    // === 개별 유저 대상 자동 지급 ===
    @Override
    public void grantPostBadges(Long userId) throws Exception {
        long postCount = boardPostMapper.countByUserId(userId);
        List<Long> badgeIds = badgeConditionService.getBadgeIdsForPostCount(postCount);
        for (Long badgeId : badgeIds) {
            giveBadge(userId, badgeId); // 알림/로그 포함
        }
    }

    @Override
    public void grantCommentBadges(Long userId) throws Exception {
        long commentCount = commentMapper.countByUserId(userId); // 반드시 commentMapper 사용
        List<Long> badgeIds = badgeConditionService.getBadgeIdsForCommentCount(commentCount);
        for (Long badgeId : badgeIds) {
            giveBadge(userId, badgeId);
        }
    }

    // === 전체 유저 배치 지급 ===
    @Override
    public void grantPostBadges() throws Exception {
        // (A) 정말 빠르게 주고 싶으면 일괄 insert만(알림 비생성). 단, 지급 이력/알림 필요시 아래 보조 코드 추가
        userBadgeMapper.grantPostBadgesAll();

        // (B) 알림/로그까지 줄 것이라면 지급 전 대상자 select 후 for문처리
        /*
        List<UserBadge> targets = userBadgeMapper.findPostBadgeGrantTargets();
        userBadgeMapper.grantPostBadgesAll();
        for (UserBadge ub : targets) {
            giveBadge(ub.getUserId(), ub.getBadgeId());
        }
        */
    }

    @Override
    public void grantCommentBadges() throws Exception {
        userBadgeMapper.grantCommentBadgesAll();
        // 아래와 같이 하고 싶으면 지급 전 대상 select + for문 알림 제공
        /*
        List<UserBadge> targets = userBadgeMapper.findCommentBadgeGrantTargets();
        userBadgeMapper.grantCommentBadgesAll();
        for (UserBadge ub : targets) {
            giveBadge(ub.getUserId(), ub.getBadgeId());
        }
        */
    }
}
