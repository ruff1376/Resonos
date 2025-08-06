package com.cosmus.resonos.controller.admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.admin.Setting;
import com.cosmus.resonos.service.admin.SettingService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/settings")
public class SettingController {

    @Autowired
    private SettingService settingService;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[SettingController] 설정 목록 요청");
        List<Setting> settings = settingService.list();
        log.info("[SettingController] 설정 수: {}", settings.size());
        model.addAttribute("settings", settings);
        return "setting/list"; // setting/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[SettingController] 설정 상세 요청 - id: {}", id);
        Setting setting = settingService.select(id);
        if (setting == null) {
            log.warn("[SettingController] 설정 없음 - id: {}", id);
            return "redirect:/settings?error=notfound";
        }
        log.info("[SettingController] 설정 상세: {}", setting);
        model.addAttribute("setting", setting);
        return "setting/detail"; // setting/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[SettingController] 설정 등록 폼 요청");
        model.addAttribute("setting", new Setting());
        return "setting/form"; // setting/form.html

    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute Setting setting, Model model) throws Exception {
        log.info("[SettingController] 설정 등록 시도: {}", setting);
        boolean success = settingService.insert(setting);
        if (success) {
            log.info("[SettingController] 설정 등록 성공: {}", setting);
            return "redirect:/settings";
        }
        log.warn("[SettingController] 설정 등록 실패: {}", setting);
        model.addAttribute("error", "등록 실패");
        return "setting/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[SettingController] 설정 수정 폼 요청 - id: {}", id);
        Setting setting = settingService.select(id);
        if (setting == null) {
            log.warn("[SettingController] 수정할 설정 없음 - id: {}", id);
            return "redirect:/settings?error=notfound";
        }
        model.addAttribute("setting", setting);
        return "setting/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute Setting setting, Model model) throws Exception {
        log.info("[SettingController] 설정 수정 시도 - id: {}, setting: {}", id, setting);
        setting.setId(id);
        boolean success = settingService.update(setting);
        if (success) {
            log.info("[SettingController] 설정 수정 성공 - id: {}", id);
            return "redirect:/settings/" + id;
        }
        log.warn("[SettingController] 설정 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "setting/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[SettingController] 설정 삭제 시도 - id: {}", id);
        settingService.delete(id);
        log.info("[SettingController] 설정 삭제 완료 - id: {}", id);
        return "redirect:/settings";
    }
}
