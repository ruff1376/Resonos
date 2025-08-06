package com.cosmus.resonos.controller.admin;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.admin.Notification;
import com.cosmus.resonos.service.admin.NotificationService;

@Controller
@RequestMapping("/admin/notifications")
public class AdminNotificationController {

    @Autowired
    private NotificationService notificationService;

    // 알림 리스트 및 새 알림 등록 폼 표시
    @GetMapping
    public String listNotifications(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) {

        if (page < 1) page = 1;
        if (size < 1) size = 10;
        if (keyword == null) keyword = "";

        try {
            // 1) 전체 알림 개수 조회 (검색 키워드 있을 경우 반영)
            long total = (!keyword.isBlank())
                    ? notificationService.countByKeyword(keyword)
                    : notificationService.countAll();

            // 2) Pagination 객체 생성 (page, size, 링크표시 개수 10, 전체 개수)
            Pagination pagination = new Pagination(page, size, 10, total);

            // 3) 알림 리스트 페이지 단위 조회
            List<Notification> notifications = (!keyword.isBlank())
                    ? notificationService.searchByKeywordPaging(keyword, pagination.getIndex(), pagination.getSize())
                    : notificationService.listPaging(pagination.getIndex(), pagination.getSize());

            // 4) Model에 데이터 전달
            model.addAttribute("notifications", notifications);
            model.addAttribute("pagination", pagination);
            model.addAttribute("keyword", keyword);

            // 5) 페이징용 URI 생성 (페이지 변경 시 size, keyword가 URL에 포함)
            String pageUri = "/admin/notifications?size=" + size;
            if (!keyword.isBlank()) {
                pageUri += "&keyword=" + URLEncoder.encode(keyword, StandardCharsets.UTF_8);
            }
            model.addAttribute("pageUri", pageUri);

        } catch (Exception e) {
            model.addAttribute("errorMessage", "알림 조회 중 오류가 발생했습니다.");
            model.addAttribute("notifications", List.of());
            model.addAttribute("pagination", new Pagination(1, size, 10, 0));
            model.addAttribute("keyword", keyword);
            model.addAttribute("pageUri", "/admin/notifications");
        }
        // 새 알림 등록용 빈 객체 (폼 바인딩용)
        model.addAttribute("notification", new Notification());

        return "admin/notifications";
    }

    // 새 알림 등록 폼 직접 접근 시에도 동일 뷰 반환 (필요시 삭제 가능)
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("notification", new Notification());
        try {
            List<Notification> notifications = notificationService.list();
            model.addAttribute("notifications", notifications);
        } catch (Exception e) {
            model.addAttribute("errorMessage", "알림 조회 중 오류가 발생했습니다.");
        }
        return "admin/notifications";
    }

    // 새 알림 등록 및 발송 처리
    @PostMapping
    public String createNotification(@ModelAttribute Notification notification, Model model) {
        try {
            notificationService.createNotification(
                    notification.getUserId(),
                    notification.getType(),
                    notification.getMessage(),
                    notification.getContent(),
                    notification.getTargetId()
            );
            return "redirect:/admin/notifications";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "알림 생성 중 오류가 발생했습니다.");
            model.addAttribute("notification", notification);
            try {
                model.addAttribute("notifications", notificationService.list());
            } catch (Exception ex) {
                // 무시 또는 추가 에러 처리
            }
            return "admin/notifications"; // 등록 실패시 알림 리스트 + 등록 폼 페이지로 포워딩
        }
    }
}
