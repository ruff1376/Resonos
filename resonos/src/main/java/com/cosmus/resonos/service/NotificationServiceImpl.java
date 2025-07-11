package com.cosmus.resonos.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Notification;
import com.cosmus.resonos.mapper.NotificationMapper;

@Service
public class NotificationServiceImpl implements NotificationService {

    @Autowired
    private NotificationMapper notificationMapper;


    @Override
    public List<Notification> list() throws Exception {
        return notificationMapper.list();
    }

    @Override
    public Notification select(Long id) throws Exception {
        return notificationMapper.select(id);
    }

    @Override
    public boolean insert(Notification notification) throws Exception {
        return notificationMapper.insert(notification) > 0;
    }

    @Override
    public boolean update(Notification notification) throws Exception {
        return notificationMapper.update(notification) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return notificationMapper.delete(id) > 0;
    }

    @Override
    public List<Notification> findByUser(Long userId) throws Exception {
        return notificationMapper.findByUser(userId);
    }

    @Override
    public boolean createPolicyViolationNotification(Long userId, String banword, Long targetId) throws Exception {
        Notification notification = new Notification();
        notification.setUserId(userId);
        notification.setType("policy_violation"); // ← 반드시 추가!
        notification.setMessage("금칙어 사용 안내");
        notification.setContent("입력하신 내용에 금칙어(" + banword + ")가 포함되어 있습니다.");
        notification.setIsRead(false);
        notification.setCreatedAt(new Date());
        notification.setTargetId(targetId);
        return insert(notification);
    }

    @Override
    public boolean createNotification(Long userId, String type, String message, String content, Long targetId) throws Exception {
        Notification notification = new Notification();
        notification.setUserId(userId);
        notification.setType(type);
        notification.setMessage(message);
        notification.setContent(content);
        notification.setIsRead(false);
        notification.setCreatedAt(new Date());
        notification.setTargetId(targetId);
        return insert(notification);
    }


}
