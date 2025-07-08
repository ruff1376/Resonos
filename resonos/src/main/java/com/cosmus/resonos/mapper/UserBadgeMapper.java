package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.UserBadge;

@Mapper
public interface UserBadgeMapper {
    // 전체 조회
    public List<UserBadge> list() throws Exception;
    // 조회
    public UserBadge select(Long id) throws Exception;
    // 삽입
    public int insert(UserBadge userBadge) throws Exception;
    // 수정
    public int update(UserBadge userBadge) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;

    // 유저 배지 자동 배분
    public List<Long> findBadgeIdsByUserId(@Param("userId") Long userId);
    public void grantBadge(@Param("userId") Long userId, @Param("badgeId") Long badgeId);

    // 
}
