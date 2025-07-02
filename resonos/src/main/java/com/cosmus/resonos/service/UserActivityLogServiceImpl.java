package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.UserActivityLog;
import com.cosmus.resonos.mapper.UserActivityLogMapper;

@Service
public class UserActivityLogServiceImpl implements UserActivityLogService {

    private final UserActivityLogMapper userActivityLogMapper;

    public UserActivityLogServiceImpl(UserActivityLogMapper userActivityLogMapper) {
        this.userActivityLogMapper = userActivityLogMapper;
    }

    // 전체 조회
    @Override
    public List<UserActivityLog> list() throws Exception {
        return userActivityLogMapper.list();
    }

    // 단건 조회
    @Override
    public UserActivityLog select(Long id) throws Exception {
        return userActivityLogMapper.select(id);
    }

    // 삽입
    @Override
    public boolean insert(UserActivityLog log) throws Exception {
        return userActivityLogMapper.insert(log) > 0;
    }

    // 수정
    @Override
    public boolean update(UserActivityLog log) throws Exception {
        return userActivityLogMapper.update(log) > 0;
    }

    // 삭제
    @Override
    public boolean delete(Long id) throws Exception {
        return userActivityLogMapper.delete(id) > 0;
    }
}
