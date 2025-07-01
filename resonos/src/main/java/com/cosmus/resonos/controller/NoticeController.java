package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Notice;
import com.cosmus.resonos.service.NoticeService;

import groovy.util.logging.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notices")
public class NoticeController {

    private final NoticeService noticeService;

    public NoticeController(NoticeService noticeService) {
        this.noticeService = noticeService;
    }

    @GetMapping
    public ResponseEntity<List<Notice>> getAllNotices() {
        try {
            List<Notice> notices = noticeService.list();
            return ResponseEntity.ok(notices);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<Notice> getNotice(@PathVariable Long id) {
        try {
            Notice notice = noticeService.select(id);
            if (notice == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(notice);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @PostMapping
    public ResponseEntity<String> createNotice(@RequestBody Notice notice) {
        try {
            boolean success = noticeService.insert(notice);
            if (success) {
                return ResponseEntity.ok("Notice created");
            }
            return ResponseEntity.status(500).body("Failed to create notice");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to create notice: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateNotice(@PathVariable Long id, @RequestBody Notice notice) {
        try {
            notice.setId(id);
            boolean success = noticeService.update(notice);
            if (success) {
                return ResponseEntity.ok("Notice updated");
            }
            return ResponseEntity.status(500).body("Failed to update notice");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to update notice: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteNotice(@PathVariable Long id) {
        try {
            boolean success = noticeService.delete(id);
            if (success) {
                return ResponseEntity.ok("Notice deleted");
            }
            return ResponseEntity.status(500).body("Failed to delete notice");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to delete notice: " + e.getMessage());
        }
    }
}
