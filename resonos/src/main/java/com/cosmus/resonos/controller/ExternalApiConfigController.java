package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.ExternalApiConfig;
import com.cosmus.resonos.service.ExternalApiConfigService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/external-api-configs")
public class ExternalApiConfigController {

    @Autowired
    private ExternalApiConfigService service;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[ExternalApiConfigController] 목록 요청");
        List<ExternalApiConfig> configs = service.list();
        log.info("[ExternalApiConfigController] config 수: {}", configs.size());
        model.addAttribute("configs", configs);
        return "externalapiconfig/list"; // externalapiconfig/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[ExternalApiConfigController] 상세 요청 - id: {}", id);
        ExternalApiConfig config = service.select(id);
        if (config == null) {
            log.warn("[ExternalApiConfigController] 없음 - id: {}", id);
            return "redirect:/external-api-configs?error=notfound";
        }
        log.info("[ExternalApiConfigController] 상세: {}", config);
        model.addAttribute("config", config);
        return "externalapiconfig/detail"; // externalapiconfig/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[ExternalApiConfigController] 등록 폼 요청");
        model.addAttribute("config", new ExternalApiConfig());
        return "externalapiconfig/form"; // externalapiconfig/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute ExternalApiConfig config, Model model) throws Exception {
        log.info("[ExternalApiConfigController] 등록 시도: {}", config);
        boolean success = service.insert(config);
        if (success) {
            log.info("[ExternalApiConfigController] 등록 성공: {}", config);
            return "redirect:/external-api-configs";
        }
        log.warn("[ExternalApiConfigController] 등록 실패: {}", config);
        model.addAttribute("error", "등록 실패");
        return "externalapiconfig/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[ExternalApiConfigController] 수정 폼 요청 - id: {}", id);
        ExternalApiConfig config = service.select(id);
        if (config == null) {
            log.warn("[ExternalApiConfigController] 수정할 config 없음 - id: {}", id);
            return "redirect:/external-api-configs?error=notfound";
        }
        model.addAttribute("config", config);
        return "externalapiconfig/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute ExternalApiConfig config, Model model) throws Exception {
        log.info("[ExternalApiConfigController] 수정 시도 - id: {}, config: {}", id, config);
        config.setId(id);
        boolean success = service.update(config);
        if (success) {
            log.info("[ExternalApiConfigController] 수정 성공 - id: {}", id);
            return "redirect:/external-api-configs/" + id;
        }
        log.warn("[ExternalApiConfigController] 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "externalapiconfig/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[ExternalApiConfigController] 삭제 시도 - id: {}", id);
        service.delete(id);
        log.info("[ExternalApiConfigController] 삭제 완료 - id: {}", id);
        return "redirect:/external-api-configs";
    }
}
