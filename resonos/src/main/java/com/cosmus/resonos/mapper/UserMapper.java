package com.cosmus.resonos.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.GenreCount;
import com.cosmus.resonos.domain.PublicUserDto;
import com.cosmus.resonos.domain.UserAuth;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.domain.UsersTotalLikes;



@Mapper
public interface UserMapper {

    // 유저

    // 회원 가입
    public int join(Users user) throws Exception;
    // 회원 권한 등록
    public int insertAuth(UserAuth userAuth) throws Exception;
    // 회원 조회(username)
    public Users select(@Param("username") String username) throws Exception;
    // 전체 조회
    public List<Users> list() throws Exception;
    // 수정
    public int update(Users user) throws Exception;
    // 회원이 수정
    public int updateFromUser(Users user) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    // 회원 권한 조회
    public List<UserAuth> listAuth() throws Exception;
    // 회원 수 조회
    public int countAll() throws Exception;
    // 아이디 찾기
    public String findId(String email) throws Exception;
    // selectPasswordById
    public String selectPasswordById(Long id) throws Exception;




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
    // 특정 권한만 삭제
    public int deleteSpecificAuth(@Param("username") String username, @Param("auth") String auth) throws Exception;
    // 권한 중복 조회
    public int hasAuth(@Param("username") String username, @Param("auth") String auth) throws Exception;
    // 비밀번호 초기화
    public int updatePassword(@Param("id") Long id, @Param("password") String password) throws Exception;
    // 회원 아이디로 조회
    public Users selectById(Long id) throws Exception;
    // 회원 아이디로 공개 정보 조회
    public PublicUserDto publicSelectById(Long id) throws Exception;
    // 비밀번호 체크
    public String checkPassword(@Param("password") String password) throws Exception;
    // 비밀번호 변경
    public int changePassword(@Param("newPassword") String newPassword, @Param("loginUserId") Long loginUserId) throws Exception;

    // 검색

    // 검색 결과 목록
    public List<Users> searchList(String keyword) throws Exception;
    // 검색 결과 전체 목록
    public List<Users> allSearchList(Map<String, Object> paramMap) throws Exception;
    // 검색 데이터 수
    public long searchCount(String keyword) throws Exception;

    // 소셜 로그인 유저 조회
    public Users findByProviderAndProviderId(@Param("provider") String provider, @Param("providerId") String providerId) throws Exception;
    // 소셜 유저 회원가입
    public int insertSnsUser(Users user) throws Exception;
    // 유저의 리뷰 전체 좋아요 수
    public UsersTotalLikes usersTotalLikes(@Param("userId") Long userId) throws Exception;

    // countByKeword - 키워드 검색
    public long countByKeyword(String keyword) throws Exception;
    // searchByKeywordPaging - 키워드 검색 페이징
    public List<Users> searchByKeywordPaging(@Param("keyword") String keyword, @Param("index") int index, @Param("size") int size) throws Exception;
    // listPaging - 전체 페이징
    public List<Users> listPaging(@Param("index") int index, @Param("size") int size) throws Exception;

    // 선호 장르 데이터 집계
    public List<GenreCount> likedGenreData(@Param("userId") Long userId) throws Exception;
    // 유저 제재 사유banUser
    public int banUser(@Param("id") Long id, @Param("ban") boolean ban, @Param("reason") String reason) throws Exception;
    // 자동 정지 처리 
    public void autoBanRepeatOffender(@Param("userId") Long userId, @Param("reason") String reason);
}
