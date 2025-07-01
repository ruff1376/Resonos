package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
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
}
