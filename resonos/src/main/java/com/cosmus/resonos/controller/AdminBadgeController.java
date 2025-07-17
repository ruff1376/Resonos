package com.cosmus.resonos.controller;

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

import com.cosmus.resonos.domain.Badge;
import com.cosmus.resonos.domain.BadgeCondition;
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

    // 배지 관리 메인 페이지
    @GetMapping
    public String badgePage(Model model) throws Exception {
        List<Badge> badges = badgeService.list(); // 항상 DB에서 select
        List<BadgeCondition> conditions = badgeConditionService.getAllConditions(); // 항상 DB에서 select

        Map<Long, List<BadgeCondition>> badgeConditionsMap = conditions.stream()
                .collect(Collectors.groupingBy(BadgeCondition::getBadgeId));

        model.addAttribute("badges", badges);
        model.addAttribute("badgeConditionsMap", badgeConditionsMap);
        // 로그로 데이터 출력 
        log.info("[AdminBadgeController] 뱃지 목록: {}", badges);
        log.info("[AdminBadgeController] 뱃지 조건 맵: {}", badgeConditionsMap);

        return "admin/badge_condition_list";
    }


    // 배지+조건 동시 등록 (오른쪽 폼)
    @PostMapping("/insert")
    public String insert(@RequestParam("name") String name,
                         @RequestParam("description") String description,
                         @RequestParam(name="iconUrl", required = false) String iconUrl,
                         @RequestParam ("conditionType") String conditionType,
                         @RequestParam("conditionValue") Integer conditionValue) throws Exception {
        // 1. 배지 등록
        Badge badge = new Badge();
        badge.setName(name);
        badge.setDescription(description);
        badge.setIconUrl(iconUrl);
        badgeService.insert(badge);

        // 2. 조건 등록
        BadgeCondition condition = new BadgeCondition();
        condition.setBadgeId(badge.getId());
        condition.setBadgeName(badge.getName());
        condition.setDescription(badge.getDescription());
        condition.setConditionType(conditionType);
        condition.setConditionValue(conditionValue);
        badgeConditionService.addCondition(condition);

        return "redirect:/admin/badge";
    }

    // 배지 조건 수정
    @PostMapping("/update")
    public String update(@RequestParam("id") Long id,
                        @RequestParam("badgeId") Long badgeId,
                        @RequestParam("badgeName") String badgeName,
                        @RequestParam("description") String description,
                        @RequestParam("conditionType") String conditionType,
                        @RequestParam("conditionValue") Integer conditionValue) throws Exception {
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
        badgeService.update(badge); // BadgeService에 update 메서드 필요





        log.info("condition:, {}", condition);

        return "redirect:/admin/badge";
    }

    // 배지 삭제 (조건도 함께 삭제)
    @PostMapping("/delete/badge/{id}")
    public String deleteBadge(@PathVariable("id") Long id) throws Exception {
        badgeService.delete(id);
        return "redirect:/admin/badge";
    }

    // 조건만 삭제 (사용 여부에 따라 필요시)
    @PostMapping("/delete/condition/{id}")
    public String deleteCondition(@PathVariable("id") Long id) throws Exception {
        badgeConditionService.deleteCondition(id);
        return "redirect:/admin/badge";
    }
        // 배지 지급
    @PostMapping("/grant")
    public String grantBadge(@RequestParam Long userId, @RequestParam Long badgeId) throws Exception {
        userBadgeService.giveBadge(userId, badgeId);
        return "success";
    }

    // 배지 회수
    @PostMapping("/revoke")
    public String revokeBadge(@RequestParam Long userId, @RequestParam Long badgeId) throws Exception {
        userBadgeService.revokeBadge(userId, badgeId);
        return "success";
    }
}
