package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.AdminLog;
import com.cosmus.resonos.service.AdminLogService;

import groovy.util.logging.Slf4j;

/*
 * meta 컬럼은 MyBatis에서 String으로 다루는 것이 가장 간단합니다.
(JSON 파싱이 필요하다면 Jackson 등으로 컨트롤러/서비스에서 처리)
created_at은 Java에서 Date 또는 LocalDateTime으로 매핑 가능(Mapper/ResultMap에서 자동 변환)
 */

@Slf4j
@Controller
@RequestMapping("/admin-logs")
public class AdminLogController {

    private final AdminLogService adminLogService;

    public AdminLogController(AdminLogService adminLogService) {
        this.adminLogService = adminLogService;
    }

    @GetMapping
    public ResponseEntity<List<AdminLog>> getAllLogs() {
        try {
            List<AdminLog> logs = adminLogService.list();
            return ResponseEntity.ok(logs);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<AdminLog> getLog(@PathVariable Long id) {
        try {
            AdminLog log = adminLogService.select(id);
            if (log == null) {
                return ResponseEntity.notFound().build();
            }
            return ResponseEntity.ok(log);
        } catch (Exception e) {
            return ResponseEntity.status(500).build();
        }
    }

    @PostMapping
    public ResponseEntity<String> createLog(@RequestBody AdminLog log) {
        try {
            boolean success = adminLogService.insert(log);
            if (success) {
                return ResponseEntity.ok("Log created");
            }
            return ResponseEntity.status(500).body("Failed to create log");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to create log: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> updateLog(@PathVariable Long id, @RequestBody AdminLog log) {
        try {
            log.setId(id);
            boolean success = adminLogService.update(log);
            if (success) {
                return ResponseEntity.ok("Log updated");
            }
            return ResponseEntity.status(500).body("Failed to update log");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to update log: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteLog(@PathVariable Long id) {
        try {
            boolean success = adminLogService.delete(id);
            if (success) {
                return ResponseEntity.ok("Log deleted");
            }
            return ResponseEntity.status(500).body("Failed to delete log");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to delete log: " + e.getMessage());
        }
    }
}
