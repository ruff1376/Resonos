package com.cosmus.resonos.mapper.admin;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.user.UserActivityLog;

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

    // 활동 로그 기록
    public List<UserActivityLog> getRecentLogsByUserId(Long userId, int limit);
    // 사용자 ID로 로그 조회
    public List<UserActivityLog> getLogsByUserId(Long userId);
}
