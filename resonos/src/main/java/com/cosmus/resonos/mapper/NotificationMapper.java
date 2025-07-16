package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.Notification;

@Mapper
public interface NotificationMapper {
    // 전체 조회
    public List<Notification> list() throws Exception;
    // 조회
    public Notification select(Long id) throws Exception;
    // 삽입
    public int insert(Notification notification) throws Exception;
    // 수정
    public int update(Notification notification) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    // 유저
    public List<Notification> findByUser(Long userId) throws Exception;

    // 정책 
    public int createPolicyViolationNotification(@Param("userId") Long userId,@Param("banword") String banword,@Param("targetId") Long targetId) throws Exception;
    // 유저용 
    public int createNotification(@Param("userId") Long userId,@Param("type") String type,@Param("message") String message,@Param("content") String content,@Param("targetId") Long targetId) throws Exception;
    
}
