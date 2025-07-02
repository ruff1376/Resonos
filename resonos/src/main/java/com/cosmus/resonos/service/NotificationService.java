package com.cosmus.resonos.service;

import java.util.List;
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
}
