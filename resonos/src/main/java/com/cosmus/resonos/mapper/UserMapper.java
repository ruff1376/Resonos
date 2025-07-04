package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.UserAuth;
import com.cosmus.resonos.domain.Users;



@Mapper
public interface UserMapper {

    // 유저

    // 회원 가입
    public int join(Users user) throws Exception;
    // 회원 권한 등록
    public int insertAuth(UserAuth userAuth) throws Exception;
    // 회원 조회
    public Users select(@Param("username") String username) throws Exception;
    // 전체 조회
    public List<Users> list() throws Exception;
    // 수정
    public int update(Users user) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    // 회원 권한 조회
    public List<UserAuth> listAuth() throws Exception;
    // 회원 수 조회
    public int countAll() throws Exception;




    //  권한 

    // 회원 권한 조회
    public List<UserAuth> selectAuthByUsername(@Param("username") String username) throws Exception;

    // 회원 권한 수정
    public int updateAuth(UserAuth userAuth) throws Exception;

    // 회원 권한 삭제
    public int deleteAuthByUsername(@Param("username") String username) throws Exception;


    // 키워드로 회원 검색
    public List<Users> searchByKeyword(@Param("keyword") String keyword) throws Exception;

    // 아이디 중복 조회
    public String findByUsername(String username) throws Exception;
    // 아이디 중복 조회
    public String findByNickname(String nickname) throws Exception;

    // 회원 활성/비활성 상태 변경
    public int updateEnabled(@Param("id") Long id, @Param("enabled") boolean enabled) throws Exception;
    // 회원 제재/해제 상태 변경
    public int updateBan(@Param("id") Long id, @Param("ban") boolean ban) throws Exception;
    
}
