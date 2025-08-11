package com.cosmus.resonos.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.admin.ExternalApiConfig;
import com.cosmus.resonos.domain.admin.Plugin;
import com.cosmus.resonos.service.admin.ExternalApiConfigService;
import com.cosmus.resonos.service.admin.PluginService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin("*")
@RestController
@RequestMapping("/admin/AnP")
public class AdminAnPController {

    @Autowired
    private ExternalApiConfigService apiService;

    @Autowired
    private PluginService pluginService;

    /** API 키 & 플러그인 목록 조회 */
    @GetMapping
    public ResponseEntity<Map<String, Object>> list() throws Exception {
        log.info("[AdminAnPRestController] API 키 및 플러그인 목록 요청");

        List<ExternalApiConfig> apiKeys = apiService.list();
        List<Plugin> plugins = pluginService.list();

        Map<String, Object> res = new HashMap<>();
        res.put("success", true);
        res.put("apiKeys", apiKeys);
        res.put("plugins", plugins);
        return ResponseEntity.ok(res);
    }

    /** API 키 등록 */
    @PostMapping("/api")
    public ResponseEntity<Map<String, Object>> createApi(@RequestBody ExternalApiConfig apiKey) throws Exception {
        log.info("[AdminAnPRestController] API 키 등록 요청: {}", apiKey);

        boolean success = apiService.insert(apiKey);
        Map<String, Object> res = new HashMap<>();
        res.put("success", success);
        res.put("message", success ? "API 키 등록 완료" : "API 키 등록 실패");
        return ResponseEntity.ok(res);
    }

    /** API 키 삭제 */
    @DeleteMapping("/api/{id}")
    public ResponseEntity<Map<String, Object>> deleteApi(@PathVariable(name = "id") Long id) throws Exception {
        log.info("[AdminAnPRestController] API 키 삭제 요청 - id: {}", id);
        apiService.delete(id);
        return ResponseEntity.ok(Map.of("success", true, "message", "API 키 삭제 완료"));
    }

    /** API 키 활성/비활성 토글 */
    @PostMapping("/api/toggle/{id}")
    public ResponseEntity<Map<String, Object>> toggleApi(@PathVariable(name = "id") Long id) throws Exception {
        log.info("[AdminAnPRestController] API 키 상태 토글 요청 - id: {}", id);
        apiService.toggleEnabled(id);
        return ResponseEntity.ok(Map.of("success", true, "message", "API 키 상태 변경 완료"));
    }

    /** 플러그인 등록 */
    @PostMapping("/plugin")
    public ResponseEntity<Map<String, Object>> createPlugin(@RequestBody Plugin plugin) throws Exception {
        log.info("[AdminAnPRestController] 플러그인 등록 요청: {}", plugin);

        boolean success = pluginService.insert(plugin);
        Map<String, Object> res = new HashMap<>();
        res.put("success", success);
        res.put("message", success ? "플러그인 등록 완료" : "플러그인 등록 실패");
        return ResponseEntity.ok(res);
    }

    /** 플러그인 삭제 */
    @DeleteMapping("/plugin/{id}")
    public ResponseEntity<Map<String, Object>> deletePlugin(@PathVariable(name = "id") Long id) throws Exception {
        log.info("[AdminAnPRestController] 플러그인 삭제 요청 - id: {}", id);
        pluginService.delete(id);
        return ResponseEntity.ok(Map.of("success", true, "message", "플러그인 삭제 완료"));
    }

    /** 플러그인 활성/비활성 토글 */
    @PostMapping("/plugin/toggle/{id}")
    public ResponseEntity<Map<String, Object>> togglePlugin(@PathVariable(name = "id") Long id) throws Exception {
        log.info("[AdminAnPRestController] 플러그인 상태 토글 요청 - id: {}", id);
        pluginService.toggleEnabled(id);
        return ResponseEntity.ok(Map.of("success", true, "message", "플러그인 상태 변경 완료"));
    }
}
