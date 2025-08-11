package com.cosmus.resonos.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.admin.UserActivityLog;
import com.cosmus.resonos.service.admin.UserActivityLogService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin("*")
@RestController
@RequestMapping("/user-activity-logs")
public class UserActivityLogRestController {

    @Autowired
    private UserActivityLogService userActivityLogService;

    // 목록 조회
    @GetMapping
    public ResponseEntity<List<UserActivityLog>> list() {
        log.info("[UserActivityLogRestController] 활동 로그 목록 요청");
        try {
            List<UserActivityLog> logs = userActivityLogService.list();
            log.info("[UserActivityLogRestController] 로그 수: {}", logs.size());
            return ResponseEntity.ok(logs);
        } catch (Exception e) {
            log.error("[UserActivityLogRestController] 활동 로그 목록 조회 실패", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // 상세 조회
    @GetMapping("/{id}")
    public ResponseEntity<?> detail(@PathVariable Long id) {
        log.info("[UserActivityLogRestController] 활동 로그 상세 요청 - id: {}", id);
        try {
            UserActivityLog logItem = userActivityLogService.select(id);
            if (logItem == null) {
                log.warn("[UserActivityLogRestController] 로그 없음 - id: {}", id);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("로그를 찾을 수 없습니다. (id: " + id + ")");
            }
            return ResponseEntity.ok(logItem);
        } catch (Exception e) {
            log.error("[UserActivityLogRestController] 상세 조회 실패 - id: {}", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }

    // 등록 처리
    @PostMapping
    public ResponseEntity<?> create(@RequestBody UserActivityLog logItem) {
        log.info("[UserActivityLogRestController] 활동 로그 등록 시도: {}", logItem);
        try {
            boolean success = userActivityLogService.insert(logItem);
            if (success) {
                log.info("[UserActivityLogRestController] 등록 성공: {}", logItem);
                return ResponseEntity.status(HttpStatus.CREATED).body(logItem);
            } else {
                log.warn("[UserActivityLogRestController] 등록 실패: {}", logItem);
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("등록 실패");
            }
        } catch (Exception e) {
            log.error("[UserActivityLogRestController] 등록 중 오류", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }

    // 수정 처리
    @PutMapping("/{id}")
    public ResponseEntity<?> update(@PathVariable Long id, @RequestBody UserActivityLog logItem) {
        log.info("[UserActivityLogRestController] 활동 로그 수정 시도 - id: {}, log: {}", id, logItem);
        try {
            logItem.setId(id);
            boolean success = userActivityLogService.update(logItem);
            if (success) {
                log.info("[UserActivityLogRestController] 수정 성공 - id: {}", id);
                return ResponseEntity.ok(logItem);
            } else {
                log.warn("[UserActivityLogRestController] 수정 실패 - id: {}", id);
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("수정 실패");
            }
        } catch (Exception e) {
            log.error("[UserActivityLogRestController] 수정 중 오류 - id: {}", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }

    // 삭제 처리
    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable Long id) {
        log.info("[UserActivityLogRestController] 활동 로그 삭제 시도 - id: {}", id);
        try {
            userActivityLogService.delete(id);
            log.info("[UserActivityLogRestController] 삭제 완료 - id: {}", id);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            log.error("[UserActivityLogRestController] 삭제 중 오류 - id: {}", id, e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("서버 오류");
        }
    }
}
