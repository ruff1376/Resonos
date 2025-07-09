package com.cosmus.resonos.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.UserFollow;
import com.cosmus.resonos.domain.Users;

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
    public boolean delete(Long loginUserId, Long id) throws Exception;
    // 팔로워 수 조회
    public int myFollowerCount(@Param("id") Long id) throws Exception;
    // 팔로우 수 조회
    public int myFollowCount(@Param("id") Long id) throws Exception;
    // 팔로워 조회
    public List<Users> myFollower(@Param("id") Long id) throws Exception;
    // 팔로우 조회
    public List<Users> myFollow(@Param("id") Long id) throws Exception;
    // 이미 팔로우 체크
    public boolean checkAlreadyFollow(Long loginUserId, Long id) throws Exception;
}
