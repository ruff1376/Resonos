package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.AdminLog;
import com.cosmus.resonos.mapper.AdminLogMapper;

@Service
public class AdminLogServiceImpl implements AdminLogService {

    @Autowired
    private AdminLogMapper adminLogMapper;

    @Override
    public List<AdminLog> list() throws Exception {
        return adminLogMapper.list();
    }

    @Override
    public AdminLog select(Long id) throws Exception {
        return adminLogMapper.select(id);
    }

    @Override
    public boolean insert(AdminLog log) throws Exception {
        return adminLogMapper.insert(log) > 0;
    }

    @Override
    public boolean update(AdminLog log) throws Exception {
        return adminLogMapper.update(log) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return adminLogMapper.delete(id) > 0;
    }
}
