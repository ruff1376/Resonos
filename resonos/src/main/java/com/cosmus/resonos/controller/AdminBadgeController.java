package com.cosmus.resonos.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cosmus.resonos.domain.Badge;
import com.cosmus.resonos.domain.BadgeCondition;
import com.cosmus.resonos.domain.UserBadge;
import com.cosmus.resonos.domain.UserBadgeLog;
import com.cosmus.resonos.service.BadgeConditionService;
import com.cosmus.resonos.service.BadgeService;
import com.cosmus.resonos.service.UserBadgeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/badge")
public class AdminBadgeController {

    @Autowired
    private BadgeService badgeService;

    @Autowired
    private BadgeConditionService badgeConditionService;

    @Autowired
    private UserBadgeService userBadgeService;

    // --- 메인: 배지+조건 현황 ---
    @GetMapping
    public String badgePage(@RequestParam(value="msg",required = false) String msg, Model model) throws Exception {
        List<Badge> badges = badgeService.list();
        List<BadgeCondition> conditions = badgeConditionService.getAllConditions();
        Map<Long, List<BadgeCondition>> badgeConditionsMap = conditions.stream()
            .collect(Collectors.groupingBy(BadgeCondition::getBadgeId));

        // 각 배지별 현재 지급자 수 카운트 (보유자)
        Map<Long, Long> badgeUserCount = userBadgeService.countByBadge();

        model.addAttribute("badges", badges);
        model.addAttribute("badgeConditionsMap", badgeConditionsMap);
        model.addAttribute("badgeUserCount", badgeUserCount);
        model.addAttribute("msg", msg);

        log.info("[AdminBadgeController] 배지 목록: {}", badges);

        return "admin/badge_condition_list";
    }

    // --- 배지+조건 등록 ---
    @PostMapping("/insert")
    public String insert(@RequestParam("name") String name,
                         @RequestParam("description") String description,
                         @RequestParam(name="iconUrl", required = false) String iconUrl,
                         @RequestParam ("conditionType") String conditionType,
                         @RequestParam("conditionValue") Integer conditionValue,
                         Model model) throws Exception {

        // 중복 조건 체크
        if(badgeConditionService.isConditionDuplicate(conditionType, conditionValue)) {
            return "redirect:/admin/badge?msg=동일 조건의 배지가 이미 존재합니다";
        }

        // 배지 등록
        Badge badge = new Badge();
        badge.setName(name);
        badge.setDescription(description);
        badge.setIconUrl(iconUrl);
        badgeService.insert(badge);

        // 조건 등록
        BadgeCondition condition = new BadgeCondition();
        condition.setBadgeId(badge.getId());
        condition.setBadgeName(name);
        condition.setDescription(description);
        condition.setConditionType(conditionType);
        condition.setConditionValue(conditionValue);
        badgeConditionService.addCondition(condition);
        String msg = "배지/조건 등록 완료";
        String encodedMsg = URLEncoder.encode(msg, StandardCharsets.UTF_8);
        return "redirect:/admin/badge?msg=" + encodedMsg;

    }



    
    // --- 배지/조건 수정 ---
    @PostMapping("/update")
    public String update(@RequestParam("id") Long id,
                        @RequestParam("badgeId") Long badgeId,
                        @RequestParam("badgeName") String badgeName,
                        @RequestParam("description") String description,
                        @RequestParam("conditionType") String conditionType,
                        @RequestParam("conditionValue") Integer conditionValue) throws Exception {

        // 조건 업데이트
        BadgeCondition condition = new BadgeCondition();
        condition.setId(id);
        condition.setBadgeId(badgeId);
        condition.setBadgeName(badgeName);
        condition.setDescription(description);
        condition.setConditionType(conditionType);
        condition.setConditionValue(conditionValue);
        badgeConditionService.updateCondition(condition);

        // 배지 정보 업데이트
        Badge badge = new Badge();
        badge.setId(badgeId);
        badge.setName(badgeName);
        badge.setDescription(description);
        badgeService.update(badge);

        // ✅ Location header에 넣을 파라미터 URL 인코딩 수행
        String msg = URLEncoder.encode("수정완료", StandardCharsets.UTF_8.toString());
        return "redirect:/admin/badge?msg=" + msg;
    }


    // --- 배지/조건 삭제 ---
    @PostMapping("/delete/badge/{id}")
    public String deleteBadge(@PathVariable("id") Long id) throws Exception {
        badgeService.delete(id);
        String msg = "삭제완료";
        String encodedMsg = URLEncoder.encode(msg, StandardCharsets.UTF_8);
        return "redirect:/admin/badge?msg=" + encodedMsg;

    }
    @PostMapping("/delete/condition/{id}")
    public String deleteCondition(@PathVariable("id") Long id) throws Exception {
        badgeConditionService.deleteCondition(id);
        String msg = "삭제완료";
        String encodedMsg = URLEncoder.encode(msg, StandardCharsets.UTF_8);
        return "redirect:/admin/badge?msg=" + encodedMsg;

    }

    // --- 배지 지급(수동), 성공/실패 메시지 반환(ajax도 가능) ---
    @PostMapping("/grant")
    @ResponseBody
    public String grantBadge(@RequestParam("userId") Long userId, @RequestParam("badgeId") Long badgeId) throws Exception {
        try {
            userBadgeService.giveBadge(userId, badgeId);
            return "success";
        } catch(Exception ex) {
            return "실패:" + ex.getMessage();
        }
    }

    // --- 배지 회수(수동) ---
    @PostMapping("/revoke")
    @ResponseBody
    public String revokeBadge(@RequestParam("userId") Long userId, @RequestParam("badgeId") Long badgeId) throws Exception {
        try {
            userBadgeService.revokeBadge(userId, badgeId);
            return "success";
        } catch(Exception ex) {
            return "실패:" + ex.getMessage();
        }
    }

    // --- 일괄(소급) 지급 ---
    @PostMapping("/grant-auto")
    public String grantBadgesAuto(@RequestParam(value = "type", required = false) String type) throws Exception {
        int count = 0;
        // ... 지급 로직 생략 ...
        // 지급 로직 
        
        String msg = count + "건 지급";
        // 아래처럼 반드시 인코딩!!
        String encodedMsg = URLEncoder.encode(msg, StandardCharsets.UTF_8);
        return "redirect:/admin/badge?msg=" + encodedMsg;
    }

    // --- 뱃지별 지급자(보유자) 리스트 ---
    @GetMapping("/badge/{badgeId}/users")
    public String badgeGivenUsersPage(@PathVariable("badgeId") Long badgeId, Model model) throws Exception {
        List<UserBadge> users = userBadgeService.listByBadge(badgeId);
        List<UserBadgeLog> logs = userBadgeService.getLog(null, badgeId);
        model.addAttribute("users", users);
        model.addAttribute("logs", logs);
        model.addAttribute("badgeId", badgeId);
        return "admin/user_badge_list";
    }

    // --- 유저별 뱃지/지급·회수 이력(로그) ---
    @GetMapping("/user/{userId}")
    public String userBadgePage(@PathVariable("userId") Long userId, Model model) throws Exception {
        List<UserBadge> badges = userBadgeService.listByUser(userId);
        List<UserBadgeLog> logs = userBadgeService.getLog(userId, null);
        model.addAttribute("userBadges", badges);
        model.addAttribute("logs", logs);
        model.addAttribute("userId", userId);
        return "admin/user_badge_list";
    }

    // --- 지급/회수 이력 전체 관리 ---
    @GetMapping("/log")
    public String badgeLogPage(@RequestParam(value = "userId", required = false) Long userId,
                               @RequestParam(value = "badgeId", required = false) Long badgeId,
                               Model model) throws Exception {
        List<UserBadgeLog> logs = userBadgeService.getLog(userId, badgeId);
        model.addAttribute("logs", logs);
        model.addAttribute("filterUserId", userId);
        model.addAttribute("filterBadgeId", badgeId);
        return "admin/badge_log_list";
    }

    // (확장) 유저, 배지 검색 지원을 위한 Ajax/Search API 추가도 가능
}
