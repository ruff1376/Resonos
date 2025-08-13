package com.cosmus.resonos.service.admin;

import java.util.List;

import com.cosmus.resonos.domain.admin.AdminLog;

public interface AdminLogService {
    // 전체조회
    public List<AdminLog> list() throws Exception;
    // 조회
    public AdminLog select(Long id) throws Exception;
    // 삽입
    public boolean insert(AdminLog log) throws Exception;
    // 수정
    public boolean update(AdminLog log) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
}