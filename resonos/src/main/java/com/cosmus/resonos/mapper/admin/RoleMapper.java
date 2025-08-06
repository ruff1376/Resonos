package com.cosmus.resonos.mapper.admin;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.admin.Role;

@Mapper
public interface RoleMapper {
    // 전체 조회
    public List<Role> list() throws Exception;
    // 조회
    public Role select(Long id) throws Exception;
    // 삽입
    public int insert(Role role) throws Exception;
    // 수정
    public int update(Role role) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
}
