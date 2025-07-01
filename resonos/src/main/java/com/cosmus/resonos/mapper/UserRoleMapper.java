package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.cosmus.resonos.domain.UserRole;

@Mapper
public interface UserRoleMapper {
    // 전체 조회
    public List<UserRole> list() throws Exception;
    // 조회
    public UserRole select(Long id) throws Exception;
    // 삽입
    public int insert(UserRole userRole) throws Exception;
    // 수정
    public int update(UserRole userRole) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
}
