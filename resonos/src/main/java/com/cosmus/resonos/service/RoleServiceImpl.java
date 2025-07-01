package com.cosmus.resonos.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.Role;
import com.cosmus.resonos.mapper.RoleMapper;

@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public List<Role> list() throws Exception {
        return roleMapper.list();
    }

    @Override
    public Role select(Long id) throws Exception {
        return roleMapper.select(id);
    }

    @Override
    public boolean insert(Role role) throws Exception {
        return roleMapper.insert(role) > 0;
    }

    @Override
    public boolean update(Role role) throws Exception {
        return roleMapper.update(role) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return roleMapper.delete(id) > 0;
    }
}
