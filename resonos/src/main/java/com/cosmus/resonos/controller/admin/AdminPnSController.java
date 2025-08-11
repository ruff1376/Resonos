package com.cosmus.resonos.controller.admin;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.admin.Policy;
import com.cosmus.resonos.domain.admin.Setting;
import com.cosmus.resonos.service.admin.PolicyService;
import com.cosmus.resonos.service.admin.SettingService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin("*")
@RestController
@RequestMapping("/admin/PolicySetting")
public class AdminPnSController {

    @Autowired
    private PolicyService policyService;
    @Autowired
    private SettingService settingService;

    /** 정책 + 설정 목록 조회 */
    @GetMapping
    public ResponseEntity<Map<String, Object>> main() throws Exception {
        List<Policy> policies = policyService.list();
        List<Setting> settings = settingService.list();
        Map<String, Setting> settingMap = settings.stream()
                .collect(Collectors.toMap(Setting::getName, s -> s));

        return ResponseEntity.ok(Map.of(
                "success", true,
                "policies", policies,
                "settings", settingMap
        ));
    }

    /** 정책 단건 조회 */
    @GetMapping("/policy/{id}")
    public ResponseEntity<?> getPolicy(@PathVariable("id") Long id) throws Exception {
        Policy policy = policyService.select(id);
        if (policy == null) {
            return ResponseEntity.status(404).body(Map.of("success", false, "message", "정책을 찾을 수 없습니다."));
        }
        return ResponseEntity.ok(Map.of("success", true, "policy", policy));
    }

    /** 정책 등록 */
    @PostMapping("/policy")
    public ResponseEntity<?> createPolicy(@RequestBody Policy policy) throws Exception {
        boolean success = policyService.insert(policy);
        return ResponseEntity.ok(Map.of("success", success, "message", success ? "등록 완료" : "등록 실패"));
    }

    /** 정책 수정 */
    @PutMapping("/policy/{id}")
    public ResponseEntity<?> updatePolicy(@PathVariable("id") Long id,
                                          @RequestBody Policy policy) throws Exception {
        policy.setId(id);
        boolean success = policyService.update(policy);
        return ResponseEntity.ok(Map.of("success", success, "message", success ? "수정 완료" : "수정 실패"));
    }

    /** 정책 삭제 */
    @DeleteMapping("/policy/{id}")
    public ResponseEntity<?> deletePolicy(@PathVariable("id") Long id) throws Exception {
        policyService.delete(id);
        return ResponseEntity.ok(Map.of("success", true, "message", "삭제 완료"));
    }

    /** 환경설정 단건 조회 */
    @GetMapping("/setting/{id}")
    public ResponseEntity<?> getSetting(@PathVariable("id") Long id) throws Exception {
        Setting setting = settingService.select(id);
        if (setting == null) {
            return ResponseEntity.status(404).body(Map.of("success", false, "message", "설정을 찾을 수 없습니다."));
        }
        return ResponseEntity.ok(Map.of("success", true, "setting", setting));
    }

    /** 환경설정 등록 */
    @PostMapping("/setting")
    public ResponseEntity<?> createSetting(@RequestBody Setting setting) throws Exception {
        boolean success = settingService.insert(setting);
        return ResponseEntity.ok(Map.of("success", success, "message", success ? "등록 완료" : "등록 실패"));
    }

    /** 환경설정 수정/저장 (name 기준 - 기존 saveOrUpdateSetting 로직 활용) */
    @PostMapping("/setting/update-batch")
    public ResponseEntity<?> updateSettings(@RequestBody Map<String, String> params) throws Exception {
        log.info("updateSetting 호출 : {}", params);

        saveOrUpdateSetting(params.get("allow_registration") != null ? "yes" : "no", "allow_registration", "신규 가입 허용 여부");
        saveOrUpdateSetting(params.get("community_board_enabled") != null ? "yes" : "no", "community_board_enabled", "커뮤니티 게시판 활성화 여부");
        saveOrUpdateSetting(params.get("external_music_data_sync") != null ? "yes" : "no", "external_music_data_sync", "음악 데이터 외부 연동 활성화 여부");
        saveOrUpdateSetting(params.getOrDefault("default_theme", "dark"), "default_theme", "기본 테마 설정 (다크/라이트)");
        saveOrUpdateSetting(params.getOrDefault("notice", ""), "notice", "공지사항");

        return ResponseEntity.ok(Map.of("success", true, "message", "설정 업데이트 완료"));
    }

    /** 환경설정 삭제 */
    @DeleteMapping("/setting/{id}")
    public ResponseEntity<?> deleteSetting(@PathVariable("id") Long id) throws Exception {
        settingService.delete(id);
        return ResponseEntity.ok(Map.of("success", true, "message", "삭제 완료"));
    }

    // ---------------------- 내부 헬퍼 메서드 ----------------------
    private void saveOrUpdateSetting(String value, String name, String description) throws Exception {
        Setting setting = settingService.selectByName(name);
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
}
