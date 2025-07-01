package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.UserBadge;

public interface UserBadgeService {
    // 전체 조회
    public List<UserBadge> list() throws Exception;
    // 조회
    public UserBadge select(Long id) throws Exception;
    // 삽입
    public boolean insert(UserBadge userBadge) throws Exception;
    // 수정
    public boolean update(UserBadge userBadge) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
}
