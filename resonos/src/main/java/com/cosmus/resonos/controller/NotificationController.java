package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosmus.resonos.domain.Notification;
import com.cosmus.resonos.service.NotificationService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notifications")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @GetMapping("")
    // TODO: @AuthenticationPrincipal 로 출력할 리스트 나누기
    public String notiList(Model model) {
        model.addAttribute("lastPath", "noti");

        return "user/notification";
    }

    @GetMapping("/{id}")
    public ResponseEntity<Notification> getNotification(@PathVariable("id") Long id) {
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
    public ResponseEntity<List<Notification>> getNotificationsByUser(@PathVariable("userId") Long userId) {
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

    @PutMapping("/{id}")
    public ResponseEntity<String> updateNotification(@PathVariable("id") Long id, @RequestBody Notification notification) {
        try {
            notification.setId(id);
            boolean success = notificationService.update(notification);
            if (success) {
                return ResponseEntity.ok("Notification updated");
            }
            return ResponseEntity.status(500).body("Failed to update notification");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to update notification: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteNotification(@PathVariable("id") Long id) {
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
