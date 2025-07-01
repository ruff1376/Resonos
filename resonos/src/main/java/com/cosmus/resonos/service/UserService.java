package com.cosmus.resonos.service;


import com.cosmus.resonos.domain.User;
import com.cosmus.resonos.domain.UserAuth;

import jakarta.servlet.http.HttpServletRequest;

public interface UserService {

    // 회원 가입
    public int join(User user) throws Exception;

    // 회원 권한 등록
    public int insertAuth(UserAuth userAuth) throws Exception;

    // 🔐 로그인
    public boolean login(User user, HttpServletRequest request);

    // 회원 조회
    public User select(String username) throws Exception;

    // 👮‍♂️ 관리자 체크
    public boolean isAdmin() throws Exception;

}
