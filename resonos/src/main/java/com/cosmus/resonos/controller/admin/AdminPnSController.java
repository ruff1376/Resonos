package com.cosmus.resonos.controller.admin;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.admin.Policy;
import com.cosmus.resonos.domain.admin.Setting;
import com.cosmus.resonos.service.admin.PolicyService;
import com.cosmus.resonos.service.admin.SettingService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin/PolicySetting")
public class AdminPnSController {

    @Autowired
    private PolicyService policyService;

    @Autowired
    private SettingService settingService;

    // 메인 화면 정책 및 설정 조회
    @GetMapping
    public String main(Model model) throws Exception {
        List<Policy> policies = policyService.list();
        List<Setting> settings = settingService.list();

        Map<String, Setting> settingMap = settings.stream()
            .collect(Collectors.toMap(Setting::getName, s -> s));

        model.addAttribute("policies", policies);
        model.addAttribute("settings", settingMap);
        return "/admin/PolicySetting";
    }

    // 정책 리스트 (중복, main과 동일하므로 생략 가능)
    @GetMapping("/policy")
    public String list(Model model) throws Exception {
        return main(model);
    }

    // 정책 상세
    @GetMapping("/policy/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        Policy policy = policyService.select(id);
        if (policy == null) return "redirect:/admin/PolicySetting?error=notfound";
        model.addAttribute("policy", policy);
        return "/admin/PolicySetting";
    }

    // 정책 등록 폼
    @GetMapping("/policy/create")
    public String create(Model model) {
        model.addAttribute("policy", new Policy());
        return "/admin/PolicySetting";
    }

    // 정책 등록 처리
    @PostMapping("/policy/create")
    public String createPost(@ModelAttribute Policy policy, Model model) throws Exception {
        boolean success = policyService.insert(policy);
        if (success) return "redirect:/admin/PolicySetting";
        model.addAttribute("error", "등록 실패");
        return "/admin/PolicySetting";
    }

    // 정책 수정 폼
    @GetMapping("/policy/update/{id}")
    public String update(@PathVariable Long id, Model model) throws Exception {
        Policy policy = policyService.select(id);
        if (policy == null) return "redirect:/admin/PolicySetting?error=notfound";
        model.addAttribute("policy", policy);
        return "/admin/PolicySetting";
    }

    // 정책 수정 처리
    @PostMapping("/policy/update/{id}")
    public String updatePost(@PathVariable Long id, @ModelAttribute Policy policy, Model model) throws Exception {
        policy.setId(id);
        if (policyService.update(policy)) return "redirect:/admin/PolicySetting";
        model.addAttribute("error", "수정 실패");
        return "/admin/PolicySetting";
    }

    // 정책 삭제
    @PostMapping("/policy/delete/{id}")
    public String delete(@PathVariable Long id) throws Exception {
        policyService.delete(id);
        return "redirect:/admin/PolicySetting";
    }

    // 환경설정 리스트 (중복, main과 동일하므로 생략 가능)
    @GetMapping("/setting")
    public String settingList(Model model) throws Exception {
        return main(model);
    }

    // 환경설정 상세
    @GetMapping("/setting/{id}")
    public String settingDetail(@PathVariable Long id, Model model) throws Exception {
        Setting setting = settingService.select(id);
        if (setting == null) return "redirect:/admin/PolicySetting?error=notfound";
        model.addAttribute("setting", setting);
        return "/admin/PolicySetting";
    }

    /**
     * 환경설정 저장/수정 헬퍼: name 으로 조회 후 없으면 insert, 있으면 update 처리
     */
    private void saveOrUpdateSetting(String value, String name, String description) throws Exception {
        log.debug("saveOrUpdateSetting 호출: value={}, name={}, description={}", value, name, description);

        // selectByName 으로 변경 권장 (value 로 조회는 논리 오류 가능성 있음)
        Setting setting = settingService.selectByName(name); // 이름 기준 조회

        Date now = new Date();
    if (setting == null) {
        setting = new Setting();
        setting.setName(name);
        setting.setDescription(description);
        setting.setValue(value);
        setting.setCreatedAt(now);
        setting.setUpdatedAt(now);

        settingService.insert(setting);
        log.info("새 설정 삽입: name={}, value={}", name, value);
    } else {
        setting.setDescription(description);
        setting.setValue(value);
        setting.setUpdatedAt(now);

        settingService.update(setting);
        log.info("기존 설정 수정: id={}, name={}, 값={}", setting.getId(), name, value);
    }

    }

    // 환경설정 등록 폼
    @GetMapping("/setting/create")
    public String createSetting(Model model) {
        model.addAttribute("setting", new Setting());
        return "/admin/PolicySetting";
    }

    // 환경설정 등록 처리
    @PostMapping("/setting/create")
    public String createSettingPost(@ModelAttribute Setting setting, Model model) throws Exception {
        boolean success = settingService.insert(setting);
        if (success) return "redirect:/admin/PolicySetting";
        model.addAttribute("error", "등록 실패");
        return "/admin/PolicySetting";
    }

    // 환경설정 업데이트 (체크박스 등 폼 파라미터 수신 후 저장)
    @PostMapping("/setting/update")
    public String updateSetting(
            @RequestParam(value = "allow_registration", required = false) String allowRegistration,
            @RequestParam(value = "community_board_enabled", required = false) String communityBoardEnabled,
            @RequestParam(value = "external_music_data_sync", required = false) String externalMusicDataSync,
            @RequestParam(value = "default_theme", required = false) String defaultTheme,
            @RequestParam(value = "notice", required = false) String notice) throws Exception {

        log.info("updateSetting 호출 : allow_registration={}, community_board_enabled={}, external_music_data_sync={}, default_theme={}, notice={}",
                allowRegistration, communityBoardEnabled, externalMusicDataSync, defaultTheme, notice);

        saveOrUpdateSetting(allowRegistration != null ? "yes" : "no", "allow_registration", "신규 가입 허용 여부");
        saveOrUpdateSetting(communityBoardEnabled != null ? "yes" : "no", "community_board_enabled", "커뮤니티 게시판 활성화 여부");
        saveOrUpdateSetting(externalMusicDataSync != null ? "yes" : "no", "external_music_data_sync", "음악 데이터 외부 연동 활성화 여부");
        saveOrUpdateSetting(defaultTheme != null ? defaultTheme : "dark", "default_theme", "기본 테마 설정 (다크/라이트)");
        saveOrUpdateSetting(notice != null ? notice : "", "notice", "공지사항");

        return "redirect:/admin/PolicySetting";
    }

    // 환경설정 삭제
    @PostMapping("/setting/delete/{id}")
    public String deleteSetting(@PathVariable Long id) throws Exception {
        settingService.delete(id);
        return "redirect:/admin/PolicySetting";
    }
}
