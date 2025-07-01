package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.UserActivityLog;

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
}
