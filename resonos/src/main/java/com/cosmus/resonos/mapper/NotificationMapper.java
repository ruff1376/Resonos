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
    // 일부 조회
    public List<Notification> selectByIds(@Param("ids") List<Long> ids);
    // 삽입
    public int insert(Notification notification) throws Exception;
    // 수정
    public int update(Notification notification) throws Exception;
    // 여러 행 수정
    public int updateIsReadByIds(@Param("ids") List<Long> ids);
    // 삭제
    public int delete(Long id) throws Exception;
    // 전체 삭제
    public int deleteAll(@Param("ids") List<Long> ids) throws Exception;
    // 유저
    public List<Notification> findByUser(Long userId) throws Exception;

    // 정책 
    public int createPolicyViolationNotification(@Param("userId") Long userId,@Param("banword") String banword,@Param("targetId") Long targetId) throws Exception;
    // 유저용 
    public int createNotification(@Param("userId") Long userId,@Param("type") String type,@Param("message") String message,@Param("content") String content,@Param("targetId") Long targetId) throws Exception;
    
    // 정책
    public int createPolicyViolationNotification(Long userId, String banword, Long targetId) throws Exception;
    // 유저용
    public int createNotification(Long userId, String type, String message, String content, Long targetId) throws Exception;
    // 읽지 않은 알림 수
    public int countUnread(@Param("userId") Long userId) throws Exception;
}
