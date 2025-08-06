package com.cosmus.resonos.service.admin;

import java.util.List;

import com.cosmus.resonos.domain.user.UserRole;

public interface UserRoleService {
    // 전체 조회
    public List<UserRole> list() throws Exception;
    // 조회
    public UserRole select(Long id) throws Exception;
    // 삽입
    public boolean insert(UserRole userRole) throws Exception;
    // 수정
    public boolean update(UserRole userRole) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
}
