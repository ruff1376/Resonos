package com.cosmus.resonos.service;

import com.cosmus.resonos.domain.BadgeCondition;
import com.cosmus.resonos.mapper.BadgeConditionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

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
}
