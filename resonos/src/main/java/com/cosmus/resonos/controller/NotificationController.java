package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Notification;
import com.cosmus.resonos.service.NotificationService;

@RestController
@RequestMapping("/notifications")
public class NotificationController {

    private final NotificationService notificationService;

    public NotificationController(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    @GetMapping
    public ResponseEntity<List<Notification>> getAllNotifications() {
        try {
            List<Notification> notifications = notificationService.list();
            return ResponseEntity.ok(notifications);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
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

    @PutMapping("/{id}")
    public ResponseEntity<String> updateNotification(@PathVariable Long id, @RequestBody Notification notification) {
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
