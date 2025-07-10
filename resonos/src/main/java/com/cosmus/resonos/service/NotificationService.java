package com.cosmus.resonos.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.Notification;

public interface NotificationService {
    // 전체 조회
    public List<Notification> list() throws Exception;
    // 조회
    public Notification select(Long id) throws Exception;
    // 삽입
    public boolean insert(Notification notification) throws Exception;
    // 수정
    public boolean update(Notification notification) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
    // 유저
    public List<Notification> findByUser(Long userId) throws Exception;

    // [추가] 정책 위반 등 알림 생성 (비즈니스 목적)
    public boolean createPolicyViolationNotification(@Param("userId") Long userId, 
        @Param("banword") String banword, @Param("targetId") String targetId) throws Exception;

    // 알림(댓글, 좋아요, 시스템, 공지)
    public boolean createNotification(@Param("userId") Long userId, @Param("type") String type,
        @Param("message") String message, @Param("content") String content, @Param("targetId") String targetId) throws Exception;

    


    
}
