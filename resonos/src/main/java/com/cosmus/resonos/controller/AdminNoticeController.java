package com.cosmus.resonos.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Notice;
import com.cosmus.resonos.service.NoticeService;

@Controller
@RequestMapping("/admin/notices")
public class AdminNoticeController {

    @Autowired
    private NoticeService noticeService;

    /**
     * 공지 목록 및 (id 지정 시) 수정할 공지 정보 전달.
     * @param id 공지 수정 시 선택된 공지 ID (optional)
     * @param model
     * @return 단일 페이지 'admin/notices' 뷰
     * @throws Exception
     */
    @GetMapping
    public String list(@RequestParam(value = "id", required = false) Long id, Model model) throws Exception {
        model.addAttribute("notices", noticeService.list());

        if (id != null) {
            Notice notice = noticeService.select(id);
            if (notice == null) {
                model.addAttribute("notice", new Notice());
            } else {
                model.addAttribute("notice", notice);
            }
        } else {
            model.addAttribute("notice", new Notice());
        }
        return "admin/notices"; // 작성하신 notices.html 템플릿 경로에 해당
    }

    /**
     * 공지 등록 및 수정 저장 처리
     * @param notice 공지 도메인 객체
     * @param result 유효성 검사 결과
     * @param model
     * @return 저장 후 공지 목록 페이지(리다이렉트)
     * @throws Exception
     */
    @PostMapping("/save")
    public String save(@ModelAttribute Notice notice, BindingResult result, Model model) throws Exception {
        if (result.hasErrors()) {
            model.addAttribute("notices", noticeService.list());
            return "admin/notices";
        }

        if (notice.getId() == null) {
            noticeService.insert(notice);
        } else {
            noticeService.update(notice);
        }
        return "redirect:/admin/notices";
    }

    /**
     * 공지 삭제 처리
     * @param id 삭제할 공지 ID
     * @return 삭제 후 공지 목록 페이지(리다이렉트)
     * @throws Exception
     */
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable("id") Long id) throws Exception {
        noticeService.delete(id);
        return "redirect:/admin/notices";
    }
}
