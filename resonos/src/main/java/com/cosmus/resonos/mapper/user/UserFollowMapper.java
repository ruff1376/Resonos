package com.cosmus.resonos.mapper.user;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.user.UserFollow;
import com.cosmus.resonos.domain.user.Users;

@Mapper
public interface UserFollowMapper {
    // 전체 조회
    public List<UserFollow> list() throws Exception;
    // 조회
    public UserFollow select(Long id) throws Exception;
    // 삽입
    public int insert(UserFollow userFollow) throws Exception;
    // 수정
    public int update(UserFollow userFollow) throws Exception;
    // 삭제
    public int delete(@Param("loginUserId") Long loginUserId, @Param("id") Long id) throws Exception;
    // 팔로워 수
    public  int countFollowers(Long userId);
    // 팔로워 수 조회
    public int myFollowerCount(@Param("id") Long id) throws Exception;
    // 팔로우 수 조회
    public int myFollowCount(@Param("id") Long id) throws Exception;
    // 팔로워 조회
    public List<Users> myFollower(@Param("id") Long id, @Param("keyword") String keyword, @Param("offset") int offset, @Param("limit") int limit) throws Exception;
    // 팔로우 조회
    public List<Users> myFollow(@Param("id") Long id, @Param("keyword") String keyword, @Param("offset") int offset, @Param("limit") int limit) throws Exception;
    // 이미 팔로우 체크
    public int checkAlreadyFollow(@Param("loginUserId") Long loginUserId, @Param("id") Long id) throws Exception;
}
