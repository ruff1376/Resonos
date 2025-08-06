package com.cosmus.resonos.service.admin;

import java.util.List;

import com.cosmus.resonos.domain.admin.UserActivityLog;

public interface UserActivityLogService {
    // 전체 조회
    public List<UserActivityLog> list() throws Exception;
    // 조회
    public UserActivityLog select(Long id) throws Exception;
    // 삽입
    public boolean insert(UserActivityLog log) throws Exception;
    // 수정
    public boolean update(UserActivityLog log) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;

    // 활동 로그 기록
    public boolean logActivity(UserActivityLog log) throws Exception;
    // getRecentLogsByUserId
    public List<UserActivityLog> getRecentLogsByUserId(Long userId, int limit) throws Exception;
    // getLogsByUserId
    public List<UserActivityLog> getLogsByUserId(Long userId) throws Exception;
}
