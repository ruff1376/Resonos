package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.UserFollow;

public interface UserFollowService {
    // 전체 조회
    public List<UserFollow> list() throws Exception;
    // 조회
    public UserFollow select(Long id) throws Exception;
    // 삽입
    public boolean insert(UserFollow userFollow) throws Exception;
    // 수정
    public boolean update(UserFollow userFollow) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
}
