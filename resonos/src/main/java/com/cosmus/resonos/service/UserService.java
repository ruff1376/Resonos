package com.cosmus.resonos.service;


import java.util.List;

import com.cosmus.resonos.domain.UserAuth;
import com.cosmus.resonos.domain.Users;

import jakarta.servlet.http.HttpServletRequest;

public interface UserService {

    // 회원 가입
    public boolean join(Users user) throws Exception;
    // 회원 권한 등록
    public int insertAuth(UserAuth userAuth) throws Exception;
    // 🔐 로그인
    public boolean login(Users user, HttpServletRequest request);
    // 회원 조회
    public Users select(String username) throws Exception;
    // 👮‍♂️ 관리자 체크
    public boolean isAdmin() throws Exception;
    // 수정
    public boolean update(Users user) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
    // 전체 조회
    public List<Users> list() throws Exception;
    // 회원 권한 조회
    public List<UserAuth> listAuth() throws Exception;
    // 회원 수 조회
    public int countAll() throws Exception;
    // 아이디 중복 조회
    public boolean findByUsername(String username) throws Exception;
    // 닉네임 중복 조회
    public boolean findByNickname(String nickname) throws Exception;
}
