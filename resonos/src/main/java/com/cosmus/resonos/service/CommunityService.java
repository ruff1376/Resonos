package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.Community;

public interface CommunityService {
    // 전체 조회
    public List<Community> list() throws Exception;
    // 조회
    public Community select(Long id) throws Exception;
    // 삽입
    public boolean insert(Community community) throws Exception;
    // 수정
    public boolean update(Community community) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
}
