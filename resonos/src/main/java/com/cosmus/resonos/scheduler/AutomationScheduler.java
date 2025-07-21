package com.cosmus.resonos.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.beans.factory.annotation.Autowired;
import com.cosmus.resonos.service.UserBadgeService;

import lombok.extern.slf4j.Slf4j;
// import com.cosmus.resonos.service.UserLevelService; 미구현 
// 필요시 다른 서비스도 추가
@Slf4j
@Component
public class AutomationScheduler {
    @Autowired private UserBadgeService userBadgeService;
    // @Autowired private UserLevelService userLevelService;
    // 추가 자동화 서비스들

    // @Scheduled(cron = "0 0 3 * * *") // 매일 새벽 3시
    @Scheduled(cron = "0 */5 * * * *") // 5분마다 0초에 실행 
    public void dailyAutomationTasks() throws Exception {
        log.info("[자동화] 일일 자동화 작업 시작");
        int b1 = userBadgeService.grantPostBadges();
        int b2 = userBadgeService.grantCommentBadges();
        // int lvlUp = userLevelService.autoGrantLevelUp(); // 레벨 시스템 구현 후 추가 미구현
        // 기타 자동 출석 집계 등 추가 가능
        // log.info("[자동화] 배지:{} 댓글배지:{} 레벨업:{}", b1, b2, lvlUp);
        log.info("[자동화] 배지:{} 댓글배지:{} 레벨업:{}", b1, b2 /*, lvlUp*/);
    }
}
