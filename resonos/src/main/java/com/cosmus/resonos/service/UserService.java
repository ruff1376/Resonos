package com.cosmus.resonos.service;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.GenreCount;
import com.cosmus.resonos.domain.PublicUserDto;
import com.cosmus.resonos.domain.UserAuth;
import com.cosmus.resonos.domain.UserNoti;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.domain.UsersTotalLikes;

import jakarta.servlet.http.HttpServletRequest;

public interface UserService {

    // 회원 가입
    public boolean join(Users user) throws Exception;
    // 아이디 찾기
    public String findId(String email) throws Exception;
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
    // 회원이 수정
    public boolean updateFromUser(Users user) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
    // 전체 조회
    public List<Users> list() throws Exception;
    // 회원 권한 조회
    public List<UserAuth> listAuth() throws Exception;
    // 회원 수 조회
    public int countAll() throws Exception;

    // 회원 권한 조회
    public List<UserAuth> selectAuthByUsername(String username) throws Exception;

    // 회원 권한 수정
    public int updateAuth(UserAuth userAuth) throws Exception;

    // 회원 권한 삭제
    public int deleteAuthByUsername(String username) throws Exception;

    // 키워드(닉네임, 이메일)로 회원 검색
    public List<Users> searchByKeyword(String keyword) throws Exception;

    // 아이디 중복 조회
    public boolean findByUsername(String username) throws Exception;
    // 닉네임 중복 조회
    public boolean findByNickname(String nickname) throws Exception;
    // 아이디 찾기
    public Users selectById(Long id) throws Exception;
    // 회원 아이디로 공개 정보 조회
    public PublicUserDto publicSelectById(Long id) throws Exception;
    // 비밀번호 체크
    public String selectPasswordById(Long id) throws Exception;
    // 비밀번호 비교
    public boolean comparePassword(String pw, String dbPw) throws Exception;
    // 비밀번호 변경
    public boolean changePassword(String newPassword, Long loginUserId) throws Exception;

    // 회원 활성/비활성 상태 변경
    public boolean enableUser(Long id, boolean enabled) throws Exception;
    // 회원 제재/해제 상태 변경
    public boolean banUser(Long id, boolean ban) throws Exception;
    // 특정 권한만 삭제
    public void deleteSpecificAuth(String username, String auth) throws Exception;
    // 권한 중복 조회
    public boolean hasAuth(String username, String auth) throws Exception;
    // 비밀번호 초기화
    public boolean updatePassword(Long id, String password) throws Exception;
    // 검색 결과 목록
    public List<Users> searchList(String keyword) throws Exception;
    // 검색 결과 전체 목록
    public List<Users> allSearchList(Map<String, Object> paramMap) throws Exception;
    // 검색 데이터 수
    public long searchCount(String keyword) throws Exception;

    // 소셜 로그인 유저 조회
    public Users findByProviderAndProviderId(String provider, String providerId) throws Exception;
    // 소셜 유저 회원가입
    public boolean insertSnsUser(Users user) throws Exception;
    // 유저의 리뷰 전체 좋아요 수
    public UsersTotalLikes usersTotalLikes(@Param("userId") Long userId) throws Exception;

    // countByKeword - 키워드 검색
    public long countByKeyword(String keyword) throws Exception;
    // searchByKeywordPaging - 키워드 검색 페이징
    List<Users> searchByKeywordPaging(String keyword, int index, int size) throws Exception;
    // listPaging - 전체 페이징
    public List<Users> listPaging(int index, int size) throws Exception;

    // 선호 장르 데이터 집계
    public List<GenreCount> likedGenreData(Long userId) throws Exception;

    // 유저 제재 사유banUser
    public boolean banUser(Long id, boolean ban, String reason) throws Exception;

    // 유저 기본 알림 세팅
    public boolean basicNotiSetting(Long userId) throws Exception;
    // 유저 알림 상태
    public List<UserNoti> getNotiStatus(Long userId) throws Exception;
    // 유저 알림 of / off
    public boolean changeNoti(UserNoti userNoti) throws Exception;
}
