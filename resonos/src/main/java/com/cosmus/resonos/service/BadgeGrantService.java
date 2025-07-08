package com.cosmus.resonos.service;


import com.cosmus.resonos.domain.BadgeCondition;
import com.cosmus.resonos.domain.UserActivitySummary;
import com.cosmus.resonos.mapper.BoardPostMapper;
import com.cosmus.resonos.mapper.CommentMapper;
import com.cosmus.resonos.mapper.UserBadgeMapper;
import com.cosmus.resonos.mapper.UserFollowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class BadgeGrantService {

    private final BadgeConditionService badgeConditionService;
    private final UserBadgeMapper userBadgeMapper;
    private final BoardPostMapper boardPostMapper;
    private final CommentMapper commentMapper;
    private final UserFollowMapper userFollowMapper;
    private final Map<String, BadgeConditionEvaluator> evaluatorMap;

    public BadgeGrantService(BadgeConditionService badgeConditionService,
                             UserBadgeMapper userBadgeMapper,
                             BoardPostMapper boardPostMapper,
                             CommentMapper commentMapper,
                             UserFollowMapper userFollowMapper,
                             List<BadgeConditionEvaluator> evaluatorList) throws Exception {
        this.badgeConditionService = badgeConditionService;
        this.userBadgeMapper = userBadgeMapper;
        this.boardPostMapper = boardPostMapper;
        this.commentMapper = commentMapper;
        this.userFollowMapper = userFollowMapper;
        this.evaluatorMap = evaluatorList.stream()
                .collect(Collectors.toMap(BadgeConditionEvaluator::getConditionType, Function.identity()));
    }

    @Transactional
    public void checkAndGrantBadges(Long userId) throws Exception {
        UserActivitySummary summary = fetchUserActivitySummary(userId);
        List<BadgeCondition> conditions = badgeConditionService.getAllConditions();
        Set<Long> currentBadgeIds = new HashSet<>(userBadgeMapper.findBadgeIdsByUserId(userId));

        for (BadgeCondition condition : conditions) {
            if (currentBadgeIds.contains(condition.getBadgeId())) continue;
            Optional.ofNullable(evaluatorMap.get(condition.getConditionType()))
                    .filter(evaluator -> evaluator.isAchieved(summary, condition))
                    .ifPresent(evaluator -> userBadgeMapper.grantBadge(userId, condition.getBadgeId()));
        }
    }

    private UserActivitySummary fetchUserActivitySummary(Long userId) throws Exception {
        return UserActivitySummary.builder()
                .userId(userId)
                .postCount(boardPostMapper.countByUserId(userId))
                .commentCount(commentMapper.countByUserId(userId))
                .followerCount(userFollowMapper.countFollowers(userId))
                .build();
    }
}
