package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.cosmus.resonos.domain.Badge;

@Mapper
public interface BadgeMapper {
    // 전체 조회
    public List<Badge> list() throws Exception;
    // 조회
    public Badge select(Long id) throws Exception;
    // 삽입
    public int insert(Badge badge) throws Exception;
    // 수정
    public int update(Badge badge) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
}
