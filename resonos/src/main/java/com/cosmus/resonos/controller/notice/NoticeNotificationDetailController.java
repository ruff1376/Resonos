package com.cosmus.resonos.controller.notice;

import com.cosmus.resonos.domain.user.Notice;
import com.cosmus.resonos.domain.user.Notification;
import com.cosmus.resonos.service.admin.NoticeService;
import com.cosmus.resonos.service.admin.NotificationService;
import com.cosmus.resonos.domain.CustomUser;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Slf4j
@Controller
@RequestMapping("") // 공란
public class NoticeNotificationDetailController {

    @Autowired
    private NoticeService noticeService;
    @Autowired
    private NotificationService notificationService;

    // 공지 상세
    @GetMapping("/notice/{id}")
    public String noticeDetail(@PathVariable("id") Long id, Model model) throws Exception {
        Notice notice = noticeService.select(id);
        if (notice == null) {
            return "redirect:/notifications2";
        }
        model.addAttribute("notice", notice);
        return "notice/notice"; // user/notice.html
    }

    // 알림 상세
    @GetMapping("/notification/{id}")
    public String notificationDetail(
            @PathVariable("id") Long id,
            @AuthenticationPrincipal CustomUser loginUser,
            Model model
    ) throws Exception {
        Notification notification = notificationService.select(id);
        if (notification == null) {
            return "redirect:/notifications2";
        }
        // 본인 알림만 접근 가능
        if (loginUser == null || !notification.getUserId().equals(loginUser.getId())) {
            return "redirect:/notifications2";
        }
        // 읽음 처리 (필요시)
        if (!Boolean.TRUE.equals(notification.getIsRead())) {
            notification.setIsRead(true);
            notificationService.update(notification);
        }
        model.addAttribute("notification", notification);
        return "notice/notification"; // user/notification.html
    }
}
