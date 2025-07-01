package com.cosmus.resonos.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.UserBadge;
import com.cosmus.resonos.mapper.UserBadgeMapper;

@Service
public class UserBadgeServiceImpl implements UserBadgeService {

    @Autowired
    private UserBadgeMapper userBadgeMapper;

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
}
