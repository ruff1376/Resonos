package com.cosmus.resonos.controller.admin;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.admin.Notification;
import com.cosmus.resonos.service.admin.NotificationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin("*") 
@RequestMapping("/admin/notifications")
public class AdminNotificationController {

    @Autowired
    private NotificationService notificationService;

    /** 알림 목록 조회 (검색, 페이징 포함) */
    @GetMapping
    public ResponseEntity<?> listNotifications(
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "size", defaultValue = "10") int size,
            @RequestParam(name = "keyword", required = false, defaultValue = "") String keyword
    ) {
        Map<String, Object> res = new HashMap<>();
        try {
            if (page < 1) page = 1;
            if (size < 1) size = 10;

            // 전체 개수
            long total = (!keyword.isBlank())
                    ? notificationService.countByKeyword(keyword)
                    : notificationService.countAll();

            // 페이징 생성
            Pagination pagination = new Pagination(page, size, 10, total);

            // 목록 조회
            List<Notification> notifications = (!keyword.isBlank())
                    ? notificationService.searchByKeywordPaging(keyword, pagination.getIndex(), pagination.getSize())
                    : notificationService.listPaging(pagination.getIndex(), pagination.getSize());

            // totalPages 계산 (프론트에서 쓰기 쉽게)
            long totalPages = pagination.getSize() > 0 ? (long) Math.ceil((double) total / pagination.getSize()) : 1;

            res.put("success", true);
            res.put("notifications", notifications != null ? notifications : List.of());
            res.put("pagination", Map.of(
                    "page", page,
                    "size", size,
                    "total", total,
                    "totalPages", totalPages
            ));
            res.put("keyword", keyword);

            String pageUri = "/admin/notifications?size=" + size;
            if (!keyword.isBlank()) {
                pageUri += "&keyword=" + URLEncoder.encode(keyword, StandardCharsets.UTF_8);
            }
            res.put("pageUri", pageUri);

        } catch (Exception e) {
            res.put("success", false);
            res.put("message", "알림 조회 중 오류가 발생했습니다.");
            res.put("notifications", List.of());
            res.put("pagination", Map.of(
                    "page", 1,
                    "size", size,
                    "total", 0,
                    "totalPages", 1
            ));
            res.put("keyword", keyword);
            res.put("pageUri", "/admin/notifications");
        }
        return ResponseEntity.ok(res);
    }

    /** 새 알림 등록 */
    @PostMapping
    public ResponseEntity<?> createNotification(@RequestBody Map<String, Object> body) {
        Map<String, Object> res = new HashMap<>();
        try {
            Long userId = body.get("userId") != null ? Long.valueOf(body.get("userId").toString()) : null;
            String type = body.get("type") != null ? body.get("type").toString() : null;
            String message = body.get("message") != null ? body.get("message").toString() : null;
            String content = body.get("content") != null ? body.get("content").toString() : null;
            String targetId = body.get("targetId") != null ? body.get("targetId").toString() : null;
            notificationService.createNotification(userId, type, message, content, targetId);

            res.put("success", true);
            res.put("message", "알림이 성공적으로 등록되었습니다.");
        } catch (Exception e) {
            res.put("success", false);
            res.put("message", "알림 생성 중 오류가 발생했습니다.");
        }
        return ResponseEntity.ok(res);
    }
}
