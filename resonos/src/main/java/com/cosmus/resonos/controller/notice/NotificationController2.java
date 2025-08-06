package com.cosmus.resonos.controller.notice;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.user.Notice;
import com.cosmus.resonos.domain.user.Notification;
import com.cosmus.resonos.service.admin.NoticeService;
import com.cosmus.resonos.service.admin.NotificationService;
import com.cosmus.resonos.domain.CustomUser;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notifications2")
public class NotificationController2 {

    @Autowired
    private NotificationService notificationService;
    @Autowired
    private NoticeService noticeService;

    // 알림 + 공지 목록 (최근 알림 통합)
    @GetMapping("")
    public String notiList(Model model, @AuthenticationPrincipal CustomUser loginUser) throws Exception {
        if (loginUser == null) return "redirect:/login";
        Long userId = loginUser.getId();
        List<Notification> notifications = notificationService.findByUser(userId);
        List<Notice> notices = noticeService.listActive();

        // 로그 찍기
        log.info("userId: {}", userId);
        log.info("notifications: {}", notifications);
        log.info("notifications.size: {}", notifications == null ? "null" : notifications.size());
        if (notifications != null) {
            for (Notification n : notifications) {
                log.info("notification: id={}, type={}, message={}, isRead={}", n.getId(), n.getType(), n.getMessage(), n.getIsRead());
            }
        }

        log.info("notices: {}", notices);
        log.info("notices.size: {}", notices == null ? "null" : notices.size());
        if (notices != null) {
            for (Notice n : notices) {
                log.info("notice: id={}, title={}", n.getId(), n.getTitle());
            }
        }

        // recentAlarms 통합 리스트 (Map 구조로 alarmType 명시)
        List<Map<String, Object>> recentAlarms = new ArrayList<>();
        if (notices != null) {
            for (Notice n : notices) {
                Map<String, Object> map = new HashMap<>();
                map.put("alarmType", "notice");
                map.put("alarm", n);
                recentAlarms.add(map);
            }
        }
        if (notifications != null) {
            for (Notification n : notifications) {
                Map<String, Object> map = new HashMap<>();
                map.put("alarmType", "notification");
                map.put("alarm", n);
                recentAlarms.add(map);
            }
        }
        // 최신순 정렬
        recentAlarms.sort((a, b) -> {
            Date dateA = (Date) ("notice".equals(a.get("alarmType")) ? ((Notice) a.get("alarm")).getCreatedAt() : ((Notification) a.get("alarm")).getCreatedAt());
            Date dateB = (Date) ("notice".equals(b.get("alarmType")) ? ((Notice) b.get("alarm")).getCreatedAt() : ((Notification) b.get("alarm")).getCreatedAt());
            return dateB.compareTo(dateA);
        });
        log.info("recentAlarms.size: {}", recentAlarms.size());

        model.addAttribute("notifications", notifications);
        model.addAttribute("notices", notices);
        model.addAttribute("recentAlarms", recentAlarms);

        return "user/notification2";
    }

    // 알림 읽음 처리
    @PostMapping("/read/{id}")
    @ResponseBody
    public ResponseEntity<?> readNotification(@PathVariable Long id, @AuthenticationPrincipal CustomUser loginUser) throws Exception {
        if (loginUser == null) return ResponseEntity.status(401).build();
        Notification noti = notificationService.select(id);
        if (noti == null || !noti.getUserId().equals(loginUser.getId())) return ResponseEntity.status(403).build();
        noti.setIsRead(true);
        notificationService.update(noti);
        return ResponseEntity.ok().build();
    }

    // 알림 전체 읽음
    @PostMapping("/readAll")
    @ResponseBody
    public ResponseEntity<?> readAll(@AuthenticationPrincipal CustomUser loginUser) throws Exception {
        if (loginUser == null) return ResponseEntity.status(401).build();
        Long userId = loginUser.getId();
        List<Notification> notifications = notificationService.findByUser(userId);
        for (Notification n : notifications) {
            if (!Boolean.TRUE.equals(n.getIsRead())) {
                n.setIsRead(true);
                notificationService.update(n);
            }
        }
        return ResponseEntity.ok().build();
    }

    // 알림 전체 삭제
    @DeleteMapping("/deleteAll")
    @ResponseBody
    public ResponseEntity<?> deleteAll(@AuthenticationPrincipal CustomUser loginUser) throws Exception {
        if (loginUser == null) return ResponseEntity.status(401).build();
        Long userId = loginUser.getId();
        List<Notification> notifications = notificationService.findByUser(userId);
        for (Notification n : notifications) {
            notificationService.delete(n.getId());
        }
        return ResponseEntity.ok().build();
    }
}
