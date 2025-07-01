package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.cosmus.resonos.domain.Community;

@Mapper
public interface CommunityMapper {
    // 전체 조회
    public List<Community> list() throws Exception;
    // 조회
    public Community select(Long id) throws Exception;
    // 삽입
    public int insert(Community community) throws Exception;
    // 수정
    public int update(Community community) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
}
