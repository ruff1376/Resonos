package com.cosmus.resonos.controller.admin;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.admin.Tag;
import com.cosmus.resonos.service.admin.TagService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin("*")
@RestController
@RequestMapping("/admin/tags")
public class AdminTagController {

    @Autowired
    private TagService tagService;

    /** 페이징 처리된 태그 목록 조회 */
    @GetMapping
    public ResponseEntity<?> list(
            @RequestParam(name = "page", defaultValue = "1") int page,
            @RequestParam(name = "size", defaultValue = "10") int size,
            @RequestParam(name = "keyword", required = false) String keyword
    ) {
        Map<String, Object> res = new HashMap<>();
        try {
            if (page < 1) page = 1;
            if (size < 1) size = 10;
            if (keyword == null) keyword = "";

            // 전체 개수 조회
            long total = (!keyword.isBlank()) ? tagService.countByKeyword(keyword) : tagService.countAll();

            // 페이징 객체
            Pagination pagination = new Pagination(page, size, 10, total);

            // 목록 조회
            List<Tag> tags = (!keyword.isBlank())
                    ? tagService.searchByNamePaging(keyword, pagination.getIndex(), pagination.getSize())
                    : tagService.listPaging(pagination.getIndex(), pagination.getSize());

            res.put("success", true);
            res.put("tags", tags != null ? tags : List.of());
            res.put("pagination", pagination);
            res.put("keyword", keyword);

            // pageUri 생성
            String pageUri = "/admin/tags?size=" + size;
            if (!keyword.isBlank()) {
                pageUri += "&keyword=" + URLEncoder.encode(keyword, StandardCharsets.UTF_8);
            }
            res.put("pageUri", pageUri);

        } catch (Exception e) {
            log.error("태그 목록 조회 오류", e);
            res.put("success", false);
            res.put("message", "태그 목록 조회 중 오류가 발생했습니다.");
            res.put("tags", List.of());
            res.put("pagination", new Pagination(1, size, 10, 0));
            res.put("keyword", keyword);
            res.put("pageUri", "/admin/tags");
        }
        return ResponseEntity.ok(res);
    }

    /** 태그 등록 */
    @PostMapping("/add")
    public ResponseEntity<?> add(@RequestBody Map<String, Object> body) {
        Map<String, Object> res = new HashMap<>();
        try {
            String name = body.get("name") != null ? body.get("name").toString() : null;
            if (name == null || name.isBlank()) {
                res.put("success", false);
                res.put("message", "태그명을 입력하세요.");
                return ResponseEntity.badRequest().body(res);
            }
            Tag tag = new Tag();
            tag.setName(name);
            tagService.insert(tag);

            res.put("success", true);
            res.put("message", "등록 완료");
        } catch (Exception e) {
            log.error("태그 등록 오류", e);
            res.put("success", false);
            res.put("message", e.getMessage());
            return ResponseEntity.internalServerError().body(res);
        }
        return ResponseEntity.ok(res);
    }

    /** 태그 수정 */
    @PutMapping("/{id}")
    public ResponseEntity<?> edit(
            @PathVariable(name = "id") Long id,
            @RequestBody Map<String, Object> body
    ) {
        Map<String, Object> res = new HashMap<>();
        try {
            String name = body.get("name") != null ? body.get("name").toString() : null;
            if (name == null || name.isBlank()) {
                res.put("success", false);
                res.put("message", "태그명을 입력하세요.");
                return ResponseEntity.badRequest().body(res);
            }
            Tag tag = new Tag();
            tag.setId(id);
            tag.setName(name);
            tagService.update(tag);

            res.put("success", true);
            res.put("message", "수정 완료");
        } catch (Exception e) {
            log.error("태그 수정 오류", e);
            res.put("success", false);
            res.put("message", e.getMessage());
            return ResponseEntity.internalServerError().body(res);
        }
        return ResponseEntity.ok(res);
    }

    /** 태그 삭제 */
    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable(name = "id") Long id) {
        Map<String, Object> res = new HashMap<>();
        try {
            tagService.delete(id);
            res.put("success", true);
            res.put("message", "삭제 완료");
        } catch (Exception e) {
            log.error("태그 삭제 오류", e);
            res.put("success", false);
            res.put("message", e.getMessage());
            return ResponseEntity.internalServerError().body(res);
        }
        return ResponseEntity.ok(res);
    }

    /** 단일 검색 (Ajax 용) */
    @GetMapping("/search")
    public ResponseEntity<?> search(@RequestParam(name = "keyword") String keyword) {
        Map<String, Object> res = new HashMap<>();
        try {
            List<Tag> tags = tagService.searchByName(keyword);
            res.put("success", true);
            res.put("tags", tags != null ? tags : List.of());
        } catch (Exception e) {
            log.error("태그 검색 오류", e);
            res.put("success", false);
            res.put("message", e.getMessage());
            return ResponseEntity.internalServerError().body(res);
        }
        return ResponseEntity.ok(res);
    }
}
