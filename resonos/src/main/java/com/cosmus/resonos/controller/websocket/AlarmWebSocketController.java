package com.cosmus.resonos.controller.websocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.cosmus.resonos.domain.Notification;
import com.cosmus.resonos.domain.Notice;

@Controller
public class AlarmWebSocketController {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    public void sendToUser(Long userId, Notification notification) {
        messagingTemplate.convertAndSend("/queue/notify-user-" + userId, notification);
    }
    public void sendNoticeToAll(Notice notice) {
        messagingTemplate.convertAndSend("/topic/notice", notice);
    }
}
