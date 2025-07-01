package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.ChartEntry;
import com.cosmus.resonos.service.ChartEntryService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chart-entries")
public class ChartEntryController {

    @Autowired
    private ChartEntryService chartEntryService;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[ChartEntryController] 차트 엔트리 목록 요청");
        List<ChartEntry> entries = chartEntryService.list();
        log.info("[ChartEntryController] 엔트리 수: {}", entries.size());
        model.addAttribute("entries", entries);
        return "chartentry/list"; // chartentry/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[ChartEntryController] 차트 엔트리 상세 요청 - id: {}", id);
        ChartEntry entry = chartEntryService.select(id);
        if (entry == null) {
            log.warn("[ChartEntryController] 엔트리 없음 - id: {}", id);
            return "redirect:/chart-entries?error=notfound";
        }
        log.info("[ChartEntryController] 엔트리 상세: {}", entry);
        model.addAttribute("entry", entry);
        return "chartentry/detail"; // chartentry/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[ChartEntryController] 차트 엔트리 등록 폼 요청");
        model.addAttribute("entry", new ChartEntry());
        return "chartentry/form"; // chartentry/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute ChartEntry entry, Model model) throws Exception {
        log.info("[ChartEntryController] 차트 엔트리 등록 시도: {}", entry);
        boolean success = chartEntryService.insert(entry);
        if (success) {
            log.info("[ChartEntryController] 차트 엔트리 등록 성공: {}", entry);
            return "redirect:/chart-entries";
        }
        log.warn("[ChartEntryController] 차트 엔트리 등록 실패: {}", entry);
        model.addAttribute("error", "등록 실패");
        return "chartentry/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[ChartEntryController] 차트 엔트리 수정 폼 요청 - id: {}", id);
        ChartEntry entry = chartEntryService.select(id);
        if (entry == null) {
            log.warn("[ChartEntryController] 수정할 엔트리 없음 - id: {}", id);
            return "redirect:/chart-entries?error=notfound";
        }
        model.addAttribute("entry", entry);
        return "chartentry/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute ChartEntry entry, Model model) throws Exception {
        log.info("[ChartEntryController] 차트 엔트리 수정 시도 - id: {}, entry: {}", id, entry);
        entry.setId(id);
        boolean success = chartEntryService.update(entry);
        if (success) {
            log.info("[ChartEntryController] 차트 엔트리 수정 성공 - id: {}", id);
            return "redirect:/chart-entries/" + id;
        }
        log.warn("[ChartEntryController] 차트 엔트리 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "chartentry/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[ChartEntryController] 차트 엔트리 삭제 시도 - id: {}", id);
        chartEntryService.delete(id);
        log.info("[ChartEntryController] 차트 엔트리 삭제 완료 - id: {}", id);
        return "redirect:/chart-entries";
    }
}
