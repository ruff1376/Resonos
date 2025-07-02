package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.ExternalApiConfig;

@Mapper
public interface ExternalApiConfigMapper {
    // 전체 조회
    public List<ExternalApiConfig> list() throws Exception;
    // 조회
    public ExternalApiConfig select(Long id) throws Exception;
    // 삽입
    public int insert(ExternalApiConfig config) throws Exception;
    // 수정
    public int update(ExternalApiConfig config) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;

}
