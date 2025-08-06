package com.cosmus.resonos.controller.admin;

import com.cosmus.resonos.domain.user.Notice;
import com.cosmus.resonos.service.admin.NoticeService;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;

@Slf4j
@Controller
@RequestMapping("/admin/notices")
public class AdminNoticeController {

    @Autowired
    private NoticeService noticeService;

    /**
     * 날짜 문자열을 java.util.Date로 변환해 주는 바인더 등록
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false); // 엄격한 형식 적용
        binder.registerCustomEditor(Date.class, new org.springframework.beans.propertyeditors.CustomDateEditor(sdf, true));
    }

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
        return "admin/notices";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute Notice notice, BindingResult result, Model model) throws Exception {
        log.info("Received notice to save: {}", notice);

        if (result.hasErrors()) {
            log.warn("Validation errors while saving notice: {}", result.getAllErrors());
            model.addAttribute("notices", noticeService.list());
            return "admin/notices";
        }

        boolean success;
        if (notice.getId() == null) {
            success = noticeService.insert(notice);
            log.info("Insert notice result: {}", success);
        } else {
            success = noticeService.update(notice);
            log.info("Update notice result: {}", success);
        }

        if (!success) {
            log.error("Failed to save notice: {}", notice);
            model.addAttribute("errorMessage", "공지 저장에 실패했습니다.");
            model.addAttribute("notices", noticeService.list());
            return "admin/notices";
        }

        return "redirect:/admin/notices";
    }

    @PostMapping("/{id}/delete")
    public String delete(@PathVariable("id") Long id) throws Exception {
        boolean success = noticeService.delete(id);
        if (!success) {
            log.error("Failed to delete notice id={}", id);
            // 에러 페이지 처리 가능
        }
        return "redirect:/admin/notices";
    }
}
