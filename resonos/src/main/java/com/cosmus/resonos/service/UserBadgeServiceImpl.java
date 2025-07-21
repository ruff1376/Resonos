package com.cosmus.resonos.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Badge;
import com.cosmus.resonos.domain.UserBadge;
import com.cosmus.resonos.domain.UserBadgeLog;
import com.cosmus.resonos.mapper.BadgeMapper;
import com.cosmus.resonos.mapper.BoardPostMapper;
import com.cosmus.resonos.mapper.CommentMapper;
import com.cosmus.resonos.mapper.UserBadgeLogMapper;
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
            // 배지 지급
            userBadgeMapper.grantBadge(userId, badgeId);

            // 배지명 조회(없으면 기본값)
            String badgeName = "배지";
            Badge badge = badgeMapper.select(badgeId);
            if (badge != null && badge.getName() != null) badgeName = badge.getName();

            // 알림 전송
            notificationService.createNotification(
                userId,
                "badge_grant",
                "새 배지 획득!",
                String.format("축하합니다! [%s] 배지를 획득했습니다.", badgeName),
                badgeId.toString()
            );

            // 지급 이력 로그 기록: (actorId, reason 등 상황 맞게 확장)
            userBadgeMapper.insertBadgeLog(
                userId,
                badgeId,
                "GRANT",
                null,           // actorId(자동이면 null, 관리자 수동이면 adminId)
                "자동·수동 지급"  // reason
            );
        }
    }

    @Override
    public void revokeBadge(Long userId, Long badgeId) throws Exception {
        if (hasBadge(userId, badgeId)) {
            // 배지 회수
            userBadgeMapper.deleteByUserAndBadge(userId, badgeId);

            String badgeName = "배지";
            Badge badge = badgeMapper.select(badgeId);
            if (badge != null && badge.getName() != null) badgeName = badge.getName();

            notificationService.createNotification(
                userId,
                "badge_revoke",
                "배지 회수",
                String.format("[%s] 배지가 회수 또는 만료되었습니다.", badgeName),
                badgeId.toString()
            );

            userBadgeMapper.insertBadgeLog(
                userId, badgeId, "REVOKE", null, "배지 회수"
            );
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
        List<Long> badgeIds = badgeConditionService.getBadgeIdsForPostCount(userId, (int)postCount);
        for (Long badgeId : badgeIds) {
            giveBadge(userId, badgeId);
        }
    }

    @Override
    public void grantCommentBadges(Long userId) throws Exception {
        long commentCount = commentMapper.countByUserId(userId);
        List<Long> badgeIds = badgeConditionService.getBadgeIdsForCommentCount(userId, (int)commentCount);
        for (Long badgeId : badgeIds) {
            giveBadge(userId, badgeId);
        }
    }


    // === 전체 유저 배치 지급 ===
    @Override
    public int grantPostBadges() throws Exception {
        // (A) 정말 빠르게 주고 싶으면 일괄 insert만(알림 비생성). 단, 지급 이력/알림 필요시 아래 보조 코드 추가
        return userBadgeMapper.grantPostBadgesAll(); // Mapper insert 결과 rowCount

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
    public int grantCommentBadges() throws Exception {
         return userBadgeMapper.grantCommentBadgesAll();
        // 아래와 같이 하고 싶으면 지급 전 대상 select + for문 알림 제공
        /*
        List<UserBadge> targets = userBadgeMapper.findCommentBadgeGrantTargets();
        userBadgeMapper.grantCommentBadgesAll();
        for (UserBadge ub : targets) {
            giveBadge(ub.getUserId(), ub.getBadgeId());
        }
        */
    }
    @Autowired
    private UserBadgeLogMapper userBadgeLogMapper;

    // 로그 조회 및 기록
    @Override
    public List<UserBadgeLog> getLog(Long userId, Long badgeId) {
        return userBadgeLogMapper.selectLogs(userId, badgeId);
    }
    // 로그 추가
    @Override
    public void addLog(Long userId, Long badgeId, String action, Long actorId, String reason) {
        UserBadgeLog log = new UserBadgeLog();
        log.setUserId(userId);
        log.setBadgeId(badgeId);
        log.setAction(action);
        log.setActorId(actorId);
        log.setReason(reason);
        userBadgeLogMapper.insertLog(log);
    }
    // Map<Long, Long> countByBadge() 
    @Override
    public Map<Long, Long> countByBadge() throws Exception {
        List<Map<String, Object>> rows = userBadgeMapper.countByBadge();
        Map<Long, Long> map = new HashMap<>();
        for (Map<String, Object> row : rows) {
            // "badge_id"와 "value" 컬럼을 꺼내 사용 (타입 캐스팅 주의)
            Long badgeId = ((Number)row.get("badge_id")).longValue();
            Long cnt = ((Number)row.get("value")).longValue();
            map.put(badgeId, cnt);
        }
        return map;
    }

    // List<UserBadge> users = userBadgeService.listByBadge(badgeId);
    @Override
    public List<UserBadge> listByBadge(Long badgeId) throws Exception {
        return userBadgeMapper.findBadgesByUserId(badgeId);
    }
    //        List<UserBadge> badges = userBadgeService.listByUser(userId);
    @Override
    public List<UserBadge> listByUser(Long userId) throws Exception {
        return userBadgeMapper.findBadgesByUserId(userId);
    }
}
