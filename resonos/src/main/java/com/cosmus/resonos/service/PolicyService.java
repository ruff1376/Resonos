package com.cosmus.resonos.service;

import java.util.List;

import com.cosmus.resonos.domain.Policy;

public interface PolicyService {
    // 전체 조회
    public List<Policy> list() throws Exception;
    // 조회
    public Policy select(Long id) throws Exception;
    // 삽입
    public boolean insert(Policy policy) throws Exception;
    // 수정
    public boolean update(Policy policy) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
}

