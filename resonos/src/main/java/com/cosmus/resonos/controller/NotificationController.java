package com.cosmus.resonos.controller;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.Notification;
import com.cosmus.resonos.service.NotificationService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notifications")
public class NotificationController {

    private final NotificationService notificationService;

    public NotificationController(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    /**
     * 단일 읽음 처리 요청
     * @param loginUser
     * @param notification
     * @return
     * @throws Exception
     */
    @PutMapping("")
    public ResponseEntity<?> read(
        @AuthenticationPrincipal CustomUser loginUser,
        @RequestBody Notification notification
    ) throws Exception {
        Notification noti = notificationService.select(notification.getId());
        Long ownerId = noti.getUserId();

        if(loginUser == null || !ownerId.equals(loginUser.getId()))
            return new ResponseEntity<>("권한이 없습니다.", HttpStatus.BAD_REQUEST);

        noti.setIsRead(true);
        boolean result = notificationService.update(noti);
        if(result) {
            int count = notificationService.countUnread(loginUser.getId());
            return new ResponseEntity<>(count, HttpStatus.OK);
        }

        return new ResponseEntity<>("서버 에러", HttpStatus.INTERNAL_SERVER_ERROR);
    }

    /**
     * 전체 읽음 처리 요청
     * @param loginUser
     * @param ids
     * @return
     * @throws Exception
     */
    @PutMapping("/all")
    public ResponseEntity<?> readAll(
        @AuthenticationPrincipal CustomUser loginUser,
        @RequestBody List<Long> ids
    ) throws Exception {
        if(ids.size() == 0) return new ResponseEntity<>("읽음 처리할 알림이 없음.", HttpStatus.BAD_REQUEST);
        if(loginUser == null)
            return new ResponseEntity<>("권한이 없습니다.", HttpStatus.BAD_REQUEST);

        List<Notification> notifications = notificationService.selectByIds(ids);

        for (Notification noti : notifications) {
            if (!noti.getUserId().equals(loginUser.getId())) {
                return new ResponseEntity<>("다른 유저의 알림이 포함되어 있습니다.", HttpStatus.BAD_REQUEST);
            }
        }

        boolean result = notificationService.updateIsReadByIds(ids);
        if(result) {
            int count = notificationService.countUnread(loginUser.getId());
            return new ResponseEntity<>(count, HttpStatus.OK);
        }

        return new ResponseEntity<>("서버 에러", HttpStatus.INTERNAL_SERVER_ERROR);
    }

    /**
     * 전체 삭제 처리 요청
     * @param loginUser
     * @param ids
     * @return
     * @throws Exception
     */
    @DeleteMapping("/all")
    public ResponseEntity<?> deleteAll(
        @AuthenticationPrincipal CustomUser loginUser,
        @RequestBody List<Long> ids
    ) throws Exception {
        if(ids.size() == 0) return new ResponseEntity<>("읽음 처리할 알림이 없음.", HttpStatus.BAD_REQUEST);
        if(loginUser == null)
            return new ResponseEntity<>("권한이 없습니다.", HttpStatus.BAD_REQUEST);

        List<Notification> notifications = notificationService.selectByIds(ids);

        for (Notification noti : notifications) {
            if (!noti.getUserId().equals(loginUser.getId())) {
                return new ResponseEntity<>("다른 유저의 알림이 포함되어 있습니다.", HttpStatus.BAD_REQUEST);
            }
        }

        boolean result = notificationService.deleteAll(ids);
        if(result) {
            int count = notificationService.countUnread(loginUser.getId());
            return new ResponseEntity<>(count, HttpStatus.OK);
        }

        return new ResponseEntity<>("서버 에러", HttpStatus.INTERNAL_SERVER_ERROR);
    }




    @GetMapping("/{id}")
    public ResponseEntity<Notification> getNotification(@PathVariable Long id) {
        try {
            Notification notification = notificationService.select(id);
            if (notification == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(notification);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Notification>> getNotificationsByUser(@PathVariable Long userId) {
        try {
            List<Notification> notifications = notificationService.findByUser(userId);
            return ResponseEntity.ok(notifications);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @PostMapping
    public ResponseEntity<String> createNotification(@RequestBody Notification notification) {
        try {
            boolean success = notificationService.insert(notification);
            if (success) {
                return ResponseEntity.ok("Notification created");
            }
            return ResponseEntity.status(500).body("Failed to create notification");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to create notification: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteNotification(@PathVariable Long id) {
        try {
            boolean success = notificationService.delete(id);
            if (success) {
                return ResponseEntity.ok("Notification deleted");
            }
            return ResponseEntity.status(500).body("Failed to delete notification");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to delete notification: " + e.getMessage());
        }
    }
}
