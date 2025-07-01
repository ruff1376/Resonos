package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.Role;

public interface RoleService {
    // 전체 조회
    public List<Role> list() throws Exception;
    // 조회
    public Role select(Long id) throws Exception;
    // 삽입
    public boolean insert(Role role) throws Exception;
    // 수정
    public boolean update(Role role) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
}
