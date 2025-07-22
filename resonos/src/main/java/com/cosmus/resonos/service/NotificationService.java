package com.cosmus.resonos.service;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.Notification;

public interface NotificationService {
    // CRUD
    public List<Notification> list() throws Exception;
    public Notification select(Long id) throws Exception;
    // 일부 조회
    public List<Notification> selectByIds(List<Long> ids);
    // 삽입
    public boolean insert(Notification notification) throws Exception;
    public boolean update(Notification notification) throws Exception;

    // "알림 생성(메시지 완성 후)" 방식
    boolean createNotification(Notification notification) throws Exception;
    // 여러 행 수정
    public boolean updateIsReadByIds(List<Long> ids);
    // 삭제
    public boolean delete(Long id) throws Exception;
    // 전체 삭제
    public boolean deleteAll(List<Long> ids) throws Exception;
    // 유저
    public List<Notification> findByUser(Long userId) throws Exception;

    // [추가] 정책 위반 등 알림 생성 (비즈니스 목적)
    // public boolean createPolicyViolationNotification(@Param("userId") Long userId,
    //     @Param("banword") String banword, @Param("targetId") String targetId) throws Exception;

    // "알림 생성(파라미터 조립식, 내부에서 객체 생성 호출)" 방식
    public void createNotification(
        @Param("userId") Long userId,
        @Param("type") String type,
        @Param("message") String message,
        @Param("content") String content,
        @Param("targetId") String targetId
    ) throws Exception;

    // ★ 필요시: 비즈니스(정책위반) 전용 생성자
    // default void notifyPolicyViolation(Long userId, String banword, String targetId) throws Exception {
    //     createNotification(userId, "policy_violation",
    //         "금칙어 사용 안내", 
    //         "입력한 내용에 금칙어(" + banword + ")가 포함되어 있습니다.",
    //         targetId
    //     );
    // }
    // 읽지 않은 알림 수
    public int countUnread(Long userId) throws Exception;

    // countByKeyword
    public long countByKeyword(String keyword) throws Exception;
    // countAll
    public long countAll() throws Exception;
    // searchByKeywordPaging
    public List<Notification> searchByKeywordPaging(
        @Param("keyword") String keyword,
        @Param("index") long index,
        @Param("size") long size
    ) throws Exception;
    // listPaging
    public List<Notification> listPaging(
        @Param("index") long index,
        @Param("size") long size
    ) throws Exception;

}
