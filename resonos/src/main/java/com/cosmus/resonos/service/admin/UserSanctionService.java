package com.cosmus.resonos.service.admin;

import java.util.List;

import com.cosmus.resonos.domain.user.UserSanction;

public interface UserSanctionService {
    // 전체 조회
    public List<UserSanction> list() throws Exception;
    // 조회
    public UserSanction select(Long id) throws Exception;
    // 삽입
    public boolean insert(UserSanction sanction) throws Exception;
    // 수정
    public boolean update(UserSanction sanction) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
    // 특정 유저의 제재 기록 조회
    public List<UserSanction> getSanctionsByUserId(Long userId) throws Exception;
    // 유저 제재
    public void banUser(Long userId, String reason, Long adminId) throws Exception;
    // 유저 제재 해제
    public void unbanUser(Long userId, Long adminId) throws Exception;
}
