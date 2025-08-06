package com.cosmus.resonos.mapper.admin;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.user.UserSanction;

@Mapper
public interface UserSanctionMapper {
    // 전체 조회
    public List<UserSanction> list() throws Exception;
    // 조회
    public UserSanction select(Long id) throws Exception;
    // 삽입
    public int insert(UserSanction sanction) throws Exception;
    // 수정
    public int update(UserSanction sanction) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    // 특정 유저의 제재 기록 조회
    public List<UserSanction> getSanctionsByUserId(Long userId) throws Exception;
    // 반복 제재 횟수 카운트, 제재 이력 저장
    public int countRecentBan(@Param("userId") Long userId, @Param("days") int days);
    public void insertBanLog(@Param("userId") Long userId, @Param("reason") String reason, @Param("adminId") Long adminId);
    public List<Long> findRepeatOffenders(@Param("days") int days, @Param("limit") int limit);

    // 유저 제재
}
