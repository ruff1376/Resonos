package com.cosmus.resonos.service.badge;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.badge.BadgeCondition;
import com.cosmus.resonos.mapper.badge.BadgeConditionMapper;

@Service
public class BadgeConditionServiceImpl implements BadgeConditionService {

    @Autowired
    private BadgeConditionMapper badgeConditionMapper;

    @Override
    public void addCondition(BadgeCondition condition) throws Exception {
        badgeConditionMapper.insert(condition);
    }

    @Override
    public void updateCondition(BadgeCondition condition) throws Exception {
        badgeConditionMapper.update(condition);
    }

    @Override
    public void deleteCondition(Long id) throws Exception {
        badgeConditionMapper.delete(id);
    }

    @Override
    public void deleteConditionsByBadgeId(Long badgeId) throws Exception {
        badgeConditionMapper.deleteByBadgeId(badgeId);
    }

    @Override
    public BadgeCondition getCondition(Long id) throws Exception {
        return badgeConditionMapper.select(id);
    }

    @Override
    public List<BadgeCondition> getAllConditions() throws Exception {
        return badgeConditionMapper.selectAll();
    }

    @Override
    public List<BadgeCondition> getConditionsByBadgeId(Long badgeId) throws Exception {
        return badgeConditionMapper.selectByBadgeId(badgeId);
    }

    @Override
    public List<Long> getBadgeIdsForPostCount(Long userId, int postCount) throws Exception {
        return badgeConditionMapper.selectBadgeIdsForPostCount(userId, postCount);
    }

    @Override
    public List<Long> getBadgeIdsForCommentCount(Long userId, int commentCount) throws Exception {
        return badgeConditionMapper.selectBadgeIdsForCommentCount(userId, commentCount);
    }
    @Override
    public boolean isConditionDuplicate(String conditionType, Integer conditionValue) throws Exception {
        return badgeConditionMapper.existsByTypeAndValue(conditionType, conditionValue) > 0;
    }

}
