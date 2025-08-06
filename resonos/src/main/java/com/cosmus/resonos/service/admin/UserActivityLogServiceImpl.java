package com.cosmus.resonos.service.admin;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.admin.UserActivityLog;
import com.cosmus.resonos.mapper.admin.UserActivityLogMapper;

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

    @Override
    public boolean logActivity(UserActivityLog log) throws Exception {
        return userActivityLogMapper.insert(log) > 0;
    }

    @Override
    public List<UserActivityLog> getRecentLogsByUserId(Long userId, int limit) throws Exception {
        return userActivityLogMapper.getRecentLogsByUserId(userId, limit);
    }

    @Override
    public List<UserActivityLog> getLogsByUserId(Long userId) throws Exception {
        return userActivityLogMapper.getLogsByUserId(userId);
    }
}
