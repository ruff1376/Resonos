package com.cosmus.resonos.mapper.admin;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.admin.Policy;

@Mapper
public interface PolicyMapper {
    // 전체 조회
    public List<Policy> list() throws Exception;
    // 조회
    public Policy select(Long id) throws Exception;
    // 삽입
    public int insert(Policy policy) throws Exception;
    // 수정
    public int update(Policy policy) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    // type으로 조회 ("banword" 정책)
    public Policy selectByType(String type);

}
