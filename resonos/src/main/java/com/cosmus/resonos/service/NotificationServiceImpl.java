package com.cosmus.resonos.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Notification;
import com.cosmus.resonos.mapper.NotificationMapper;
import com.cosmus.resonos.controller.websocket.AlarmWebSocketController;

@Service
public class NotificationServiceImpl implements NotificationService {
    @Autowired
    private NotificationMapper notificationMapper;

    @Autowired
    private AlarmWebSocketController alarmSocketController;

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
        boolean result = notificationMapper.insert(notification) > 0;
        // 실시간 푸시
        if (result) {
            alarmSocketController.sendToUser(notification.getUserId(), notification);
        }
        return result;
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
    public boolean createNotification(Notification notification) throws Exception {
        notification.setIsRead(false);
        notification.setCreatedAt(new Date());
        return this.insert(notification);
    }
    public List<Notification> selectByIds(List<Long> ids) {
        return notificationMapper.selectByIds(ids);
    }

    @Override
    public boolean updateIsReadByIds(List<Long> ids) {
        return notificationMapper.updateIsReadByIds(ids) > ids.size() - 1;
    }

    @Override
    public boolean deleteAll(List<Long> ids) throws Exception {
        return notificationMapper.deleteAll(ids) > ids.size() - 1;
    }

    @Override
    public int countUnread(Long userId) throws Exception {
        return notificationMapper.countUnread(userId);
    }

    // public boolean createPolicyViolationNotification(Long userId, String banword, String targetId) throws Exception {
    //     Notification notification = new Notification();
    //     notification.setUserId(userId);
    //     notification.setType("policy_violation"); // ← 반드시 추가!
    //     notification.setMessage("금칙어 사용 안내");
    //     notification.setContent("입력하신 내용에 금칙어(" + banword + ")가 포함되어 있습니다.");
    //     notification.setIsRead(false);
    //     notification.setCreatedAt(new Date());
    //     notification.setTargetId(targetId);
    //     return insert(notification);
    // }

    // public boolean createNotification(Long userId, String type, String message, String content, String targetId) throws Exception {
    //     Notification notification = new Notification();
    //     notification.setUserId(userId);
    //     notification.setType(type);
    //     notification.setMessage(message);
    //     notification.setContent(content);
    //     notification.setIsRead(false);
    //     notification.setCreatedAt(new Date());
    //     notification.setTargetId(targetId);
    //     return insert(notification);
    // }

    @Override
    public void createNotification(Long userId, String type, String message, String content, String targetId) throws Exception {
        Notification notification = new Notification();
        notification.setUserId(userId);
        notification.setType(type);
        notification.setMessage(message);
        notification.setContent(content);
        notification.setTargetId(targetId);
        notification.setIsRead(false);
        notification.setCreatedAt(new Date());
        createNotification(notification); // 위의 객체 기반 메서드 호출
    }

    // [선택] 비즈니스 목적(예: 정책위반 등) 전용 notify 메서드는 필요시만 추가
    /*
    @Override
    public void notifyPolicyViolation(Long userId, String banword, String targetId) throws Exception {
        createNotification(
            userId,
            "policy_violation",
            "금칙어 사용 안내",
            "입력하신 내용에 금칙어(" + banword + ")가 포함되어 있습니다.",
            targetId
        );
    }
    */
}
