package com.cosmus.resonos.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosmus.resonos.domain.Notice;
import com.cosmus.resonos.service.NoticeService;

@Controller
@RequestMapping("/admin/notices")
public class AdminNoticeController {

    private final NoticeService noticeService;

    public AdminNoticeController(NoticeService noticeService) {
        this.noticeService = noticeService;
    }

    // 공지 목록
    @GetMapping
    public String list(Model model) throws Exception {
        model.addAttribute("notices", noticeService.list());
        return "admin/notice/list";
    }

    // 공지 등록 폼
    @GetMapping("/new")
    public String createForm(Model model) throws Exception {
        model.addAttribute("notice", new Notice());
        return "admin/notice/form";
    }

    // 공지 등록 처리
    @PostMapping
    public String create(@ModelAttribute Notice notice) throws Exception {
        noticeService.insert(notice);
        return "redirect:/admin/notices";
    }

    // 공지 수정 폼
    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) throws Exception {
        model.addAttribute("notice", noticeService.select(id));
        return "admin/notice/form";
    }

    // 공지 수정 처리
    @PostMapping("/{id}/edit")
    public String update(@PathVariable Long id, @ModelAttribute Notice notice) throws Exception {
        notice.setId(id);
        noticeService.update(notice);
        return "redirect:/admin/notices";
    }

    // 공지 삭제
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        noticeService.delete(id);
        return "redirect:/admin/notices";
    }
}

