package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.ExternalApiConfig;
import com.cosmus.resonos.domain.Plugin;
import com.cosmus.resonos.service.ExternalApiConfigService;
import com.cosmus.resonos.service.PluginService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/AnP")
public class AdminAnPController {

    @Autowired
    private ExternalApiConfigService apiService;

    @Autowired
    private PluginService pluginService;

    // 목록 (GET /admin/AnP)
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[AdminAnPController] API 키 및 플러그인 목록 요청");
        List<ExternalApiConfig> apiKeys = apiService.list();
        List<Plugin> plugins = pluginService.list();
        model.addAttribute("apiKeys", apiKeys);
        model.addAttribute("plugins", plugins);
        return "/admin/AnP"; // /admin/AnP.html
    }

    // API 키 등록 (POST /admin/AnP/createApi)
    @PostMapping("/createApi")
    public String createApi(@ModelAttribute ExternalApiConfig apiKey, Model model) throws Exception {
        log.info("[AdminAnPController] API 키 등록 시도: {}", apiKey);
        boolean success = apiService.insert(apiKey);
        if (!success) {
            log.warn("[AdminAnPController] API 키 등록 실패: {}", apiKey);
            model.addAttribute("error", "API 키 등록 실패");
        }
        return "redirect:/admin/AnP";
    }

    // API 키 삭제 (POST /admin/AnP/deleteApit/{id})
    @PostMapping("/deleteApit/{id}")
    public String deleteApi(@PathVariable("id") Long id) throws Exception {
        log.info("[AdminAnPController] API 키 삭제 시도 - id: {}", id);
        apiService.delete(id);
        return "redirect:/admin/AnP";
    }

    // API 키 활성/비활성 토글 (POST /admin/AnP/api/toggle/{id})
    @PostMapping("api/toggle/{id}")
    public String toggleApi(@PathVariable("id") Long id) throws Exception {
        log.info("[AdminAnPController] API 키 상태 토글 시도 - id: {}", id);
        apiService.toggleEnabled(id);
        return "redirect:/admin/AnP";
    }

    // 플러그인 등록 (POST /admin/AnP/createPlugin)
    @PostMapping("/createPlugin")
    public String createPlugin(@ModelAttribute Plugin plugin, Model model) throws Exception {
        log.info("[AdminAnPController] 플러그인 등록 시도: {}", plugin);
        boolean success = pluginService.insert(plugin);
        if (!success) {
            log.warn("[AdminAnPController] 플러그인 등록 실패: {}", plugin);
            model.addAttribute("error", "플러그인 등록 실패");
        }
        return "redirect:/admin/AnP";
    }

    // 플러그인 삭제 (POST /admin/AnP/delete/{id})
    @PostMapping("/delete/{id}")
    public String deletePlugin(@PathVariable("id") Long id) throws Exception {
        log.info("[AdminAnPController] 플러그인 삭제 시도 - id: {}", id);
        pluginService.delete(id);
        return "redirect:/admin/AnP";
    }

    // 플러그인 활성/비활성 토글 (POST /admin/AnP/plugin/toggle/{id})
    @PostMapping("/plugin/toggle/{id}")
    public String togglePlugin(@PathVariable("id") Long id) throws Exception {
        log.info("[AdminAnPController] 플러그인 상태 토글 시도 - id: {}", id);
        pluginService.toggleEnabled(id);
        return "redirect:/admin/AnP";
    }
}
