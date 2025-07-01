package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.cosmus.resonos.domain.UserActivityLog;

@Mapper
public interface UserActivityLogMapper {
    // 전체 조회
    public List<UserActivityLog> list() throws Exception;
    // 조회
    public UserActivityLog select(Long id) throws Exception;
    // 삽입
    public int insert(UserActivityLog log) throws Exception;
    // 수정
    public int update(UserActivityLog log) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
}
