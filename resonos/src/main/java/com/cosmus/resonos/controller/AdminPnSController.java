package com.cosmus.resonos.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cosmus.resonos.domain.Policy;
import com.cosmus.resonos.domain.Setting;
import com.cosmus.resonos.service.PolicyService;
import com.cosmus.resonos.service.SettingService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/PolicySetting")
public class AdminPnSController {

    @Autowired
    private PolicyService policyService;

    @Autowired
    private SettingService settingService;


    // 메인
    @GetMapping
    public String main(Model model) throws Exception {
        List<Policy> policies = policyService.list();
        List<Setting> settings = settingService.list();

        // ✅ Null 방지를 위해 항상 Map 형태로 전환
        Map<String, Setting> settingMap = settings.stream()
            .collect(java.util.stream.Collectors.toMap(Setting::getName, java.util.function.Function.identity()));

        model.addAttribute("policies", policies);
        model.addAttribute("settings", settingMap);
        return "/admin/PolicySetting";
    }


    // 목록
    @GetMapping("/policy")
    public String list(Model model) throws Exception {
        List<Policy> policies = policyService.list();
        List<Setting> settings = settingService.list();
        Map<String, Setting> settingMap = settings.stream()
            .collect(java.util.stream.Collectors.toMap(Setting::getName, java.util.function.Function.identity()));
        model.addAttribute("policies", policies);
        model.addAttribute("settings", settingMap);
        return "/admin/PolicySetting";
    }

    // 상세
    @GetMapping("/policy/{id}")
    public String detail(@PathVariable("id") Long id, Model model) throws Exception {
        Policy policy = policyService.select(id);
        if (policy == null) return "redirect:/admin/PolicySetting?error=notfound";
        model.addAttribute("policy", policy);
        return "/admin/PolicySetting"; // policy/detail.html
    }

    // 등록 폼
    @GetMapping("/policy/create")
    public String create(@ModelAttribute Policy policy, Model model) {
        log.info("폼으로 전달된 정책: {}", policy);
        model.addAttribute("policy", new Policy());
        return "/admin/PolicySetting"; // policy/form.html
    }

    // 등록 처리
    @PostMapping("/policy/create")
    public String createPost(@ModelAttribute Policy policy, Model model) throws Exception {
        boolean success = policyService.insert(policy);
        if (success) {
            return "redirect:/admin/PolicySetting";
        }
        model.addAttribute("error", "등록 실패");
        return "/admin/PolicySetting";
    }


    // 수정 폼
    @GetMapping("/policy/update/{id}")
    public String update(@PathVariable("id") Long id, Model model) throws Exception {
        Policy policy = policyService.select(id);
        if (policy == null) return "redirect:/admin/PolicySetting?error=notfound";
        model.addAttribute("policy", policy);
        return "/admin/PolicySetting";
    }

    // 수정 처리
    @PostMapping("/policy/update/{id}")
    public String updatePost(@PathVariable("id") Long id, @ModelAttribute Policy policy, Model model) throws Exception {
        policy.setId(id);
        if (policyService.update(policy)) return "redirect:/admin/PolicySetting";
        model.addAttribute("error", "수정 실패");
        return "/admin/PolicySetting";
    }

    // 삭제
    @PostMapping("/policy/delete/{id}")
    public String delete(@PathVariable("id") Long id) throws Exception {
        policyService.delete(id);
        return "redirect:/admin/PolicySetting";
    }





    // 환경설정

    // 목록
    @GetMapping("/setting")
    public String settingList(Model model) throws Exception {
        List<Setting> settings = settingService.list();
        Map<String, Setting> settingMap = settings.stream()
            .collect(java.util.stream.Collectors.toMap(Setting::getName, java.util.function.Function.identity()));
        model.addAttribute("settings", settingMap);
        return "/admin/PolicySetting"; // policy/setting.html
    }

    // 상세
    @GetMapping("/setting/{id}")
    public String settingDetail(@PathVariable("id") Long id, Model model) throws Exception {
        Setting setting = settingService.select(id);
        if (setting == null) return "redirect:/admin/PolicySetting?error=notfound";
        model.addAttribute("setting", setting);
        return "/admin/PolicySetting"; // policy/setting.html
    }

    // 등록
    @GetMapping("/setting/create")
    public String createSetting(Model model) {
        model.addAttribute("setting", new Setting());
        return "/admin/PolicySetting"; // policy/setting_form.html
    }

    // 등록 처리
    @PostMapping("/setting/create")
    public String createSettingPost(@ModelAttribute Setting setting, Model model) throws Exception {
        boolean success = settingService.insert(setting);
        if (success) {
            return "redirect:/admin/PolicySetting";
        }
        model.addAttribute("error", "등록 실패");
        return "/admin/PolicySetting";
    }



    // 수정
    @PostMapping("/setting/update")
    public String updateSetting(
            @RequestParam(value = "allow_registration", required = false) String allowRegistration,
            @RequestParam(value = "community_board_enabled", required = false) String communityBoardEnabled,
            @RequestParam(value = "external_music_data_sync", required = false) String externalMusicDataSync,
            @RequestParam(value = "default_theme", required = false) String defaultTheme,
            @RequestParam(value = "notice", required = false) String notice
    ) throws Exception {
        saveOrUpdateSetting(1L, allowRegistration != null ? "yes" : "no", "allow_registration", "신규 가입 허용 여부");
        saveOrUpdateSetting(2L, communityBoardEnabled != null ? "yes" : "no", "community_board_enabled", "커뮤니티 게시판 활성화 여부");
        saveOrUpdateSetting(3L, externalMusicDataSync != null ? "yes" : "no", "external_music_data_sync", "음악 데이터 외부 연동 활성화 여부");
        saveOrUpdateSetting(4L, defaultTheme != null ? defaultTheme : "dark", "default_theme", "기본 테마 설정 (다크/라이트)");
        saveOrUpdateSetting(5L, notice != null ? notice : "", "notice", "공지사항");
        return "redirect:/admin/PolicySetting";
    }

    // id로 환경설정 저장/수정 (없으면 insert, 있으면 update)
    private void saveOrUpdateSetting(Long id, String value, String name, String description) throws Exception {
        Setting setting = settingService.select(id);
        Date now = new Date();
        if (setting == null) {
            setting = new Setting();
            setting.setId(id);
            setting.setName(name);
            setting.setDescription(description);
            setting.setValue(value);
            setting.setUpdatedAt(now);
            setting.setCreatedAt(now);
            settingService.insert(setting);
        } else {
            setting.setValue(value);
            setting.setName(name);
            setting.setDescription(description);
            setting.setUpdatedAt(now);
            settingService.update(setting);
        }
    }

    // 삭제
    @PostMapping("/setting/delete/{id}")
    public String deleteSetting(@PathVariable("id") Long id) throws Exception {
        settingService.delete(id);
        return "redirect:/admin/PolicySetting";
    }

}

