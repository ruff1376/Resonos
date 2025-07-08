package com.cosmus.resonos.controller;

import com.cosmus.resonos.domain.Badge;
import com.cosmus.resonos.domain.BadgeCondition;
import com.cosmus.resonos.service.BadgeConditionService;
import com.cosmus.resonos.service.BadgeService;

import lombok.extern.slf4j.Slf4j;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Controller
@RequestMapping("/admin/badge")
public class AdminBadgeController {

    @Autowired
    private BadgeService badgeService;

    @Autowired
    private BadgeConditionService badgeConditionService;

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
    public String insert(@RequestParam String name,
                         @RequestParam String description,
                         @RequestParam(required = false) String iconUrl,
                         @RequestParam String conditionType,
                         @RequestParam Integer conditionValue) throws Exception {
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
    public String update(@RequestParam Long id,
                        @RequestParam Long badgeId,
                        @RequestParam String badgeName,
                        @RequestParam String description,
                        @RequestParam String conditionType,
                        @RequestParam Integer conditionValue) throws Exception {
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
    public String deleteBadge(@PathVariable Long id) throws Exception {
        badgeService.delete(id);
        return "redirect:/admin/badge";
    }

    // 조건만 삭제 (사용 여부에 따라 필요시)
    @PostMapping("/delete/condition/{id}")
    public String deleteCondition(@PathVariable Long id) throws Exception {
        badgeConditionService.deleteCondition(id);
        return "redirect:/admin/badge";
    }
}
