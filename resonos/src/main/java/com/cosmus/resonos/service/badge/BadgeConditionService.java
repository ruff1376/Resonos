package com.cosmus.resonos.service.badge;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.admin.BadgeCondition;

public interface BadgeConditionService {
    // 배지 CRUD
    public void addCondition(BadgeCondition condition) throws Exception;
    public void updateCondition(BadgeCondition condition) throws Exception;
    public void deleteCondition(Long id) throws Exception;
    public void deleteConditionsByBadgeId(Long badgeId) throws Exception;
    public BadgeCondition getCondition(Long id) throws Exception;
    public List<BadgeCondition> getAllConditions() throws Exception;
    public List<BadgeCondition> getConditionsByBadgeId(Long badgeId) throws Exception;

    public List<Long> getBadgeIdsForPostCount(@Param("userId") Long userId, int postCount) throws Exception;
    public List<Long> getBadgeIdsForCommentCount(@Param("userId") Long userId, int commentCount) throws Exception;
    public boolean isConditionDuplicate(@Param("conditionType") String conditionType, @Param("conditionValue") Integer conditionValue) throws Exception;
}
