package com.cosmus.resonos.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.Badge;
import com.cosmus.resonos.mapper.BadgeMapper;

@Service
public class BadgeServiceImpl implements BadgeService {

    @Autowired
    private BadgeMapper badgeMapper;

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
    public boolean delete(Long id) throws Exception {
        return badgeMapper.delete(id) > 0;
    }
}
