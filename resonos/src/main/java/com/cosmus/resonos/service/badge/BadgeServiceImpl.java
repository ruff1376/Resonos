package com.cosmus.resonos.service.badge;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.admin.Badge;
import com.cosmus.resonos.mapper.badge.BadgeMapper;

@Service
public class BadgeServiceImpl implements BadgeService {

    @Autowired
    private BadgeMapper badgeMapper;

    @Autowired
    private BadgeConditionService badgeConditionService;


    @Override
    public List<Badge> list() throws Exception {
        return badgeMapper.list();
    }

    @Override
    public Badge select(Long id) throws Exception {
        return badgeMapper.select(id);
    }

    @Override
    public boolean insert(Badge badge) throws Exception {
        return badgeMapper.insert(badge) > 0;
    }

    @Override
    public boolean update(Badge badge) throws Exception {
        return badgeMapper.update(badge) > 0;
    }

    @Override
    @Transactional
    public boolean delete(Long id) throws Exception {
        // 1. 이 뱃지를 참조하는 모든 조건을 먼저 삭제
        badgeConditionService.deleteConditionsByBadgeId(id);

        // 2. 뱃지 삭제
        int affectedRows = badgeMapper.delete(id);
        return affectedRows > 0;
    }

    @Override
    public List<Badge> haveBadge(Long loginUserId) throws Exception {
        return badgeMapper.haveBadge(loginUserId);
    }

    @Override
    public List<Badge> doesNotHaveBadge(Long loginUserId) throws Exception {
        return badgeMapper.doesNotHaveBadge(loginUserId);
    }

    @Override
    public boolean checkBadge(Long loginUserId, Long badgeId) throws Exception {
        return badgeMapper.checkBadge(loginUserId, badgeId) > 0;
    }

    @Override
    public List<Badge> recentGetBadge(Long id) throws Exception {
        return badgeMapper.recentGetBadge(id);
    }

    @Override
    public int badgeCount(Long id) throws Exception {
        return badgeMapper.badgeCount(id);
    }
}
