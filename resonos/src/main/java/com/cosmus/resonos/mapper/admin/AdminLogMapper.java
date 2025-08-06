package com.cosmus.resonos.mapper.admin;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.admin.AdminLog;

@Mapper
public interface AdminLogMapper {
    // 전체 조회
    public List<AdminLog> list() throws Exception;
    // 조회
    public AdminLog select(Long id) throws Exception;
    // 삽입
    public int insert(AdminLog log) throws Exception;
    // 수정
    public int update(AdminLog log) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
}