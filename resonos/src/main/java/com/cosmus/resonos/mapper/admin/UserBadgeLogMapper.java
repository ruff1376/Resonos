package com.cosmus.resonos.mapper.admin;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.admin.UserBadgeLog;

@Mapper
public interface UserBadgeLogMapper {
    // 전체 로그 조회 (필터: userId, badgeId 옵션)
    List<UserBadgeLog> selectLogs(@Param("userId") Long userId, @Param("badgeId") Long badgeId);

    // 개별 로그 insert
    int insertLog(UserBadgeLog log);
}
