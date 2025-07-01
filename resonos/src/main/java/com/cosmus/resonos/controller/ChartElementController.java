package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.ChartElement;
import com.cosmus.resonos.service.ChartElementService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chart-elements")
public class ChartElementController {

    @Autowired
    private ChartElementService chartElementService;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[ChartElementController] 차트 요소 목록 요청");
        List<ChartElement> elements = chartElementService.list();
        log.info("[ChartElementController] 요소 수: {}", elements.size());
        model.addAttribute("elements", elements);
        return "chartelement/list"; // chartelement/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[ChartElementController] 차트 요소 상세 요청 - id: {}", id);
        ChartElement element = chartElementService.select(id);
        if (element == null) {
            log.warn("[ChartElementController] 요소 없음 - id: {}", id);
            return "redirect:/chart-elements?error=notfound";
        }
        log.info("[ChartElementController] 요소 상세: {}", element);
        model.addAttribute("element", element);
        return "chartelement/detail"; // chartelement/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[ChartElementController] 차트 요소 등록 폼 요청");
        model.addAttribute("element", new ChartElement());
        return "chartelement/form"; // chartelement/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute ChartElement element, Model model) throws Exception {
        log.info("[ChartElementController] 차트 요소 등록 시도: {}", element);
        boolean success = chartElementService.insert(element);
        if (success) {
            log.info("[ChartElementController] 차트 요소 등록 성공: {}", element);
            return "redirect:/chart-elements";
        }
        log.warn("[ChartElementController] 차트 요소 등록 실패: {}", element);
        model.addAttribute("error", "등록 실패");
        return "chartelement/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[ChartElementController] 차트 요소 수정 폼 요청 - id: {}", id);
        ChartElement element = chartElementService.select(id);
        if (element == null) {
            log.warn("[ChartElementController] 수정할 요소 없음 - id: {}", id);
            return "redirect:/chart-elements?error=notfound";
        }
        model.addAttribute("element", element);
        return "chartelement/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute ChartElement element, Model model) throws Exception {
        log.info("[ChartElementController] 차트 요소 수정 시도 - id: {}, element: {}", id, element);
        element.setId(id);
        boolean success = chartElementService.update(element);
        if (success) {
            log.info("[ChartElementController] 차트 요소 수정 성공 - id: {}", id);
            return "redirect:/chart-elements/" + id;
        }
        log.warn("[ChartElementController] 차트 요소 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "chartelement/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[ChartElementController] 차트 요소 삭제 시도 - id: {}", id);
        chartElementService.delete(id);
        log.info("[ChartElementController] 차트 요소 삭제 완료 - id: {}", id);
        return "redirect:/chart-elements";
    }
}
