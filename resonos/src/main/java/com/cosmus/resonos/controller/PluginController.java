package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Plugin;
import com.cosmus.resonos.service.PluginService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/plugins")
public class PluginController {

    @Autowired
    private PluginService pluginService;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[PluginController] 플러그인 목록 요청");
        List<Plugin> plugins = pluginService.list();
        log.info("[PluginController] 플러그인 수: {}", plugins.size());
        model.addAttribute("plugins", plugins);
        return "plugin/list"; // plugin/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[PluginController] 플러그인 상세 요청 - id: {}", id);
        Plugin plugin = pluginService.select(id);
        if (plugin == null) {
            log.warn("[PluginController] 플러그인 없음 - id: {}", id);
            return "redirect:/plugins?error=notfound";
        }
        log.info("[PluginController] 플러그인 상세: {}", plugin);
        model.addAttribute("plugin", plugin);
        return "plugin/detail"; // plugin/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[PluginController] 플러그인 등록 폼 요청");
        model.addAttribute("plugin", new Plugin());
        return "plugin/form"; // plugin/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute Plugin plugin, Model model) throws Exception {
        log.info("[PluginController] 플러그인 등록 시도: {}", plugin);
        boolean success = pluginService.insert(plugin);
        if (success) {
            log.info("[PluginController] 플러그인 등록 성공: {}", plugin);
            return "redirect:/plugins";
        }
        log.warn("[PluginController] 플러그인 등록 실패: {}", plugin);
        model.addAttribute("error", "등록 실패");
        return "plugin/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[PluginController] 플러그인 수정 폼 요청 - id: {}", id);
        Plugin plugin = pluginService.select(id);
        if (plugin == null) {
            log.warn("[PluginController] 수정할 플러그인 없음 - id: {}", id);
            return "redirect:/plugins?error=notfound";
        }
        model.addAttribute("plugin", plugin);
        return "plugin/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute Plugin plugin, Model model) throws Exception {
        log.info("[PluginController] 플러그인 수정 시도 - id: {}, plugin: {}", id, plugin);
        plugin.setId(id);
        boolean success = pluginService.update(plugin);
        if (success) {
            log.info("[PluginController] 플러그인 수정 성공 - id: {}", id);
            return "redirect:/plugins/" + id;
        }
        log.warn("[PluginController] 플러그인 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "plugin/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[PluginController] 플러그인 삭제 시도 - id: {}", id);
        pluginService.delete(id);
        log.info("[PluginController] 플러그인 삭제 완료 - id: {}", id);
        return "redirect:/plugins";
    }
}
