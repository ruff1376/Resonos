package com.cosmus.resonos.mapper.badge;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.badge.BadgeCondition;

import java.util.List;

@Mapper
public interface BadgeConditionMapper {
    public void insert(BadgeCondition condition);
    public void update(BadgeCondition condition);
    public void delete(Long id);
    public BadgeCondition select(Long id);
    public List<BadgeCondition> selectAll();
    public List<BadgeCondition> selectByBadgeId(Long badgeId);
    public void deleteByBadgeId(Long badgeId);
    public List<Long> selectBadgeIdsForPostCount(@Param("userId") Long userId, @Param("postCount") int postCount);
    public List<Long> selectBadgeIdsForCommentCount(@Param("userId") Long userId, @Param("commentCount") int commentCount);
    // (badgeConditionService.isConditionDuplicate(conditionType, conditionValue))
    public int existsByTypeAndValue(@Param("conditionType") String conditionType, @Param("conditionValue") Integer conditionValue);
}
