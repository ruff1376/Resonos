package com.cosmus.resonos.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.UserRole;
import com.cosmus.resonos.mapper.UserRoleMapper;

@Service
public class UserRoleServiceImpl implements UserRoleService {

    @Autowired
    private UserRoleMapper userRoleMapper;

    @Override
    public List<UserRole> list() throws Exception {
        return userRoleMapper.list();
    }

    @Override
    public UserRole select(Long id) throws Exception {
        return userRoleMapper.select(id);
    }

    @Override
    public boolean insert(UserRole userRole) throws Exception {
        return userRoleMapper.insert(userRole) > 0;
    }

    @Override
    public boolean update(UserRole userRole) throws Exception {
        return userRoleMapper.update(userRole) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return userRoleMapper.delete(id) > 0;
    }
}
