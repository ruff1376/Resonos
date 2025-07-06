package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.cosmus.resonos.domain.Notification;
import com.cosmus.resonos.service.NotificationService;

@RestController
@RequestMapping("/admin/notifications")
public class AdminNotificationController {

    private final NotificationService notificationService;

    public AdminNotificationController(NotificationService notificationService) {
        this.notificationService = notificationService;
    }

    // 전체 알림 목록
    @GetMapping
    public ResponseEntity<List<Notification>> getAll() throws Exception {
        return ResponseEntity.ok(notificationService.list());
    }

    // 알림 삭제
    @DeleteMapping("/{id}")
    public ResponseEntity<String> delete(@PathVariable Long id) throws Exception {
        boolean success = notificationService.delete(id);
        if (success) return ResponseEntity.ok("삭제 완료");
        return ResponseEntity.status(500).body("삭제 실패");
    }
}

