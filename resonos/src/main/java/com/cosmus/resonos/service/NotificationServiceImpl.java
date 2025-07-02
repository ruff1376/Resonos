package com.cosmus.resonos.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.Notification;
import com.cosmus.resonos.mapper.NotificationMapper;

@Service
public class NotificationServiceImpl implements NotificationService {

    private final NotificationMapper notificationMapper;

    public NotificationServiceImpl(NotificationMapper notificationMapper) {
        this.notificationMapper = notificationMapper;
    }

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
}
