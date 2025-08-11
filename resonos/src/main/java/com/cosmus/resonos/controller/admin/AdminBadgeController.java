package com.cosmus.resonos.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.cosmus.resonos.domain.admin.BadgeConditionRequest;
import com.cosmus.resonos.domain.admin.UserBadgeLog;
import com.cosmus.resonos.domain.badge.Badge;
import com.cosmus.resonos.domain.badge.BadgeCondition;
import com.cosmus.resonos.domain.badge.UserBadge;
import com.cosmus.resonos.service.admin.UserBadgeService;
import com.cosmus.resonos.service.badge.BadgeConditionService;
import com.cosmus.resonos.service.badge.BadgeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin("*")
@RestController
@RequestMapping("/admin/badge")
public class AdminBadgeController {

    @Autowired
    private BadgeService badgeService;

    @Autowired
    private BadgeConditionService badgeConditionService;

    @Autowired
    private UserBadgeService userBadgeService;

    /** 배지 + 조건 현황 조회 */
    @GetMapping
    public ResponseEntity<?> getBadgePage(
            @RequestParam(value = "msg", required = false) String msg
    ) throws Exception {
        List<Badge> badges = badgeService.list();
        List<BadgeCondition> conditions = badgeConditionService.getAllConditions();
        Map<Long, List<BadgeCondition>> badgeConditionsMap =
                conditions != null
                        ? conditions.stream().collect(Collectors.groupingBy(BadgeCondition::getBadgeId))
                        : Map.of();
        Map<Long, Long> badgeUserCount =
                userBadgeService.countByBadge() != null ? userBadgeService.countByBadge() : Map.of();

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("badges", badges != null ? badges : List.of());
        result.put("badgeConditionsMap", badgeConditionsMap);
        result.put("badgeUserCount", badgeUserCount);
        result.put("msg", msg); // null 허용

        return ResponseEntity.ok(result);
    }

    /** 배지+조건 등록 */
    @PostMapping("/insert")
    public ResponseEntity<?> insertBadgeCondition(@RequestBody BadgeConditionRequest req) throws Exception {

        if (badgeConditionService.isConditionDuplicate(req.getConditionType(), req.getConditionValue())) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "동일 조건의 배지가 이미 존재합니다");
            return ResponseEntity.badRequest().body(errorResponse);
        }

        Badge badge = new Badge();
        badge.setName(req.getName());
        badge.setDescription(req.getDescription());
        badge.setIconUrl(req.getIconUrl());
        badgeService.insert(badge);

        BadgeCondition condition = new BadgeCondition();
        condition.setBadgeId(badge.getId());
        condition.setBadgeName(req.getName());
        condition.setDescription(req.getDescription());
        condition.setConditionType(req.getConditionType());
        condition.setConditionValue(req.getConditionValue());
        badgeConditionService.addCondition(condition);

        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        res.put("message", "배지/조건 등록 완료");
        return ResponseEntity.ok(res);
    }


    /** 배지/조건 수정 */
    @PutMapping("/update")
    public ResponseEntity<?> updateBadgeCondition(
            @RequestParam(name = "id") Long id,
            @RequestParam(name = "badgeId") Long badgeId,
            @RequestParam(name = "badgeName") String badgeName,
            @RequestParam(name = "description") String description,
            @RequestParam(name = "conditionType") String conditionType,
            @RequestParam(name = "conditionValue") Integer conditionValue
    ) throws Exception {

        BadgeCondition condition = new BadgeCondition();
        condition.setId(id);
        condition.setBadgeId(badgeId);
        condition.setBadgeName(badgeName);
        condition.setDescription(description);
        condition.setConditionType(conditionType);
        condition.setConditionValue(conditionValue);
        badgeConditionService.updateCondition(condition);

        Badge badge = new Badge();
        badge.setId(badgeId);
        badge.setName(badgeName);
        badge.setDescription(description);
        badgeService.update(badge);

        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        res.put("message", "수정완료");
        return ResponseEntity.ok(res);
    }

    /** 배지 삭제 */
    @DeleteMapping("/delete/badge/{id}")
    public ResponseEntity<?> deleteBadge(@PathVariable(name = "id") Long id) throws Exception {
        badgeService.delete(id);
        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        res.put("message", "삭제완료");
        return ResponseEntity.ok(res);
    }

    /** 조건 삭제 */
    @DeleteMapping("/delete/condition/{id}")
    public ResponseEntity<?> deleteCondition(@PathVariable(name = "id") Long id) throws Exception {
        badgeConditionService.deleteCondition(id);
        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        res.put("message", "삭제완료");
        return ResponseEntity.ok(res);
    }

    /** 배지 지급(수동) */
    @PostMapping("/grant")
    public ResponseEntity<?> grantBadge(
            @RequestParam(name = "userId") Long userId,
            @RequestParam(name = "badgeId") Long badgeId
    ) throws Exception {
        try {
            userBadgeService.giveBadge(userId, badgeId);
            Map<String, Object> res = new HashMap<>();
            res.put("success", true);
            res.put("message", "success");
            return ResponseEntity.ok(res);
        } catch (Exception ex) {
            Map<String, Object> res = new HashMap<>();
            res.put("success", false);
            res.put("message", ex.getMessage());
            return ResponseEntity.badRequest().body(res);
        }
    }

    /** 배지 회수(수동) */
    @PostMapping("/revoke")
    public ResponseEntity<?> revokeBadge(
            @RequestParam(name = "userId") Long userId,
            @RequestParam(name = "badgeId") Long badgeId
    ) throws Exception {
        try {
            userBadgeService.revokeBadge(userId, badgeId);
            Map<String, Object> res = new HashMap<>();
            res.put("success", true);
            res.put("message", "success");
            return ResponseEntity.ok(res);
        } catch (Exception ex) {
            Map<String, Object> res = new HashMap<>();
            res.put("success", false);
            res.put("message", ex.getMessage());
            return ResponseEntity.badRequest().body(res);
        }
    }

    /** 일괄(소급) 지급 */
    @PostMapping("/grant-auto")
    public ResponseEntity<?> grantBadgesAuto(
            @RequestParam(name = "type", required = false) String type
    ) throws Exception {
        int count = 0;
        // 지급 로직 구현 필요
        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        res.put("message", count + "건 지급");
        return ResponseEntity.ok(res);
    }

    /** 뱃지별 지급자(보유자) 리스트 */
    @GetMapping("/badge/{badgeId}/users")
    public ResponseEntity<?> badgeGivenUsersPage(
            @PathVariable(name = "badgeId") Long badgeId
    ) throws Exception {
        List<UserBadge> users = userBadgeService.listByBadge(badgeId);
        List<UserBadgeLog> logs = userBadgeService.getLog(null, badgeId);
        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        res.put("users", users != null ? users : List.of());
        res.put("logs", logs != null ? logs : List.of());
        res.put("badgeId", badgeId);
        return ResponseEntity.ok(res);
    }

    /** 유저별 배지 & 로그 */
    @GetMapping("/user/{userId}")
    public ResponseEntity<?> userBadgePage(
            @PathVariable(name = "userId") Long userId
    ) throws Exception {
        List<UserBadge> badges = userBadgeService.listByUser(userId);
        List<UserBadgeLog> logs = userBadgeService.getLog(userId, null);
        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        res.put("userBadges", badges != null ? badges : List.of());
        res.put("logs", logs != null ? logs : List.of());
        res.put("userId", userId);
        return ResponseEntity.ok(res);
    }

    /** 지급/회수 이력 전체 */
    @GetMapping("/log")
    public ResponseEntity<?> badgeLogPage(
            @RequestParam(name = "userId", required = false) Long userId,
            @RequestParam(name = "badgeId", required = false) Long badgeId
    ) throws Exception {
        List<UserBadgeLog> logs = userBadgeService.getLog(userId, badgeId);
        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        res.put("logs", logs != null ? logs : List.of());
        res.put("filterUserId", userId);
        res.put("filterBadgeId", badgeId);
        return ResponseEntity.ok(res);
    }
}
