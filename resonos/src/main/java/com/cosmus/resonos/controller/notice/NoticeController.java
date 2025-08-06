package com.cosmus.resonos.controller.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.user.Notice;
import com.cosmus.resonos.service.admin.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notices")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    // 공지사항 목록 화면
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[NoticeController] 공지사항 목록 요청");
        List<Notice> notices = noticeService.list();
        log.info("[NoticeController] 공지사항 수: {}", notices.size());
        model.addAttribute("notices", notices);
        return "notice/list"; // notice/list.html
    }

    // 공지사항 상세 화면
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[NoticeController] 공지사항 상세 요청 - id: {}", id);
        Notice notice = noticeService.select(id);
        if (notice == null) {
            log.warn("[NoticeController] 공지사항 없음 - id: {}", id);
            return "redirect:/notices?error=notfound";
        }
        log.info("[NoticeController] 공지사항 상세: {}", notice);
        model.addAttribute("notice", notice);
        return "notice/detail"; // notice/detail.html
    }

    // 공지사항 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[NoticeController] 공지사항 등록 폼 요청");
        model.addAttribute("notice", new Notice());
        return "notice/form"; // notice/form.html
    }

    // 공지사항 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute Notice notice, Model model) throws Exception {
        log.info("[NoticeController] 공지사항 등록 시도: {}", notice);
        boolean success = noticeService.insert(notice);
        if (success) {
            log.info("[NoticeController] 공지사항 등록 성공: {}", notice);
            return "redirect:/notices";
        }
        log.warn("[NoticeController] 공지사항 등록 실패: {}", notice);
        model.addAttribute("error", "등록 실패");
        return "notice/form";
    }

    // 공지사항 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[NoticeController] 공지사항 수정 폼 요청 - id: {}", id);
        Notice notice = noticeService.select(id);
        if (notice == null) {
            log.warn("[NoticeController] 수정할 공지사항 없음 - id: {}", id);
            return "redirect:/notices?error=notfound";
        }
        model.addAttribute("notice", notice);
        return "notice/form";
    }

    // 공지사항 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute Notice notice, Model model) throws Exception {
        log.info("[NoticeController] 공지사항 수정 시도 - id: {}, notice: {}", id, notice);
        notice.setId(id);
        boolean success = noticeService.update(notice);
        if (success) {
            log.info("[NoticeController] 공지사항 수정 성공 - id: {}", id);
            return "redirect:/notices/" + id;
        }
        log.warn("[NoticeController] 공지사항 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "notice/form";
    }

    // 공지사항 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[NoticeController] 공지사항 삭제 시도 - id: {}", id);
        noticeService.delete(id);
        log.info("[NoticeController] 공지사항 삭제 완료 - id: {}", id);
        return "redirect:/notices";
    }
}
