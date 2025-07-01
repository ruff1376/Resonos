package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.Badge;

public interface BadgeService {
    // 전체 조회
    public List<Badge> list() throws Exception;
    // 조회
    public Badge select(Long id) throws Exception;
    // 삽입
    public boolean insert(Badge badge) throws Exception;
    // 수정
    public boolean update(Badge badge) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
}
