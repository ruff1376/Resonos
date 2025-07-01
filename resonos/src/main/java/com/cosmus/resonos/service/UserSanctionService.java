package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.UserSanction;

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
}
