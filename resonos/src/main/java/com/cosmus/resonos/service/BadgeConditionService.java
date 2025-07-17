package com.cosmus.resonos.service;

import com.cosmus.resonos.domain.BadgeCondition;
import com.cosmus.resonos.domain.UserActivitySummary;

import java.util.List;

public interface BadgeConditionService {
    // 배지 CRUD
    public void addCondition(BadgeCondition condition) throws Exception;
    public void updateCondition(BadgeCondition condition) throws Exception;
    public void deleteCondition(Long id) throws Exception;
    public void deleteConditionsByBadgeId(Long badgeId) throws Exception;
    public BadgeCondition getCondition(Long id) throws Exception;
    public List<BadgeCondition> getAllConditions() throws Exception;
    public List<BadgeCondition> getConditionsByBadgeId(Long badgeId) throws Exception;

    public List<Long> getBadgeIdsForPostCount(Long userId, int postCount) throws Exception;
    public List<Long> getBadgeIdsForCommentCount(Long userId, int commentCount) throws Exception;
}
