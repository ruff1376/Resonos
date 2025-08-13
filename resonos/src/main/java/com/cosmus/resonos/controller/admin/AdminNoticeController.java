package com.cosmus.resonos.controller.admin;

import com.cosmus.resonos.domain.admin.Notice;
import com.cosmus.resonos.service.admin.NoticeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * REST 기반 공지 관리 컨트롤러
 */
@Slf4j
@CrossOrigin("*")
@RestController
@RequestMapping("/admin/notices")
public class AdminNoticeController {

    @Autowired
    private NoticeService noticeService;

    /**
     * 날짜 문자열 → java.util.Date 변환 바인더 등록
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        sdf.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
    }

    /**
     * 공지 목록 조회
     * GET /admin/notices
     */
    @GetMapping
    public Map<String, Object> list(
        @RequestParam(name = "page", defaultValue = "1") int page,
        @RequestParam(name = "size", defaultValue = "10") int size,
        @RequestParam(name = "keyword", required = false) String keyword,
        @RequestParam(name = "id", required = false) Long id
    ) {
        Map<String, Object> result = new HashMap<>();
        try {
            // TODO: 서비스에 page, size, keyword로 목록 조회 구현
            List<Notice> notices = noticeService.list(/* page,size,keyword */);
            result.put("success", true);
            result.put("notices", notices);

            if (id != null) {
                Notice notice = noticeService.select(id);
                result.put("notice", notice != null ? notice : new Notice());
            }

            // 페이지네이션 정보 예시
            Map<String, Object> pagination = new HashMap<>();
            pagination.put("page", page);
            pagination.put("size", size);
            pagination.put("total", notices.size());
            pagination.put("totalPages", 1);
            result.put("pagination", pagination);

        } catch (Exception e) {
            log.error("공지 목록 조회 실패", e);
            result.put("success", false);
            result.put("message", "공지 목록 조회 중 오류");
        }
        return result;
}

    /**
     * 공지 저장 (등록 / 수정)
     * POST /admin/notices/save
     */
    @PostMapping("/save")
    public Map<String, Object> save(@RequestBody Map<String, Object> params) throws Exception {
        Map<String, Object> result = new HashMap<>();
        try {
            Long id = params.get("id") != null ? Long.valueOf(params.get("id").toString()) : null;
            String title = (String) params.get("title");
            String content = (String) params.get("content");
            Date createdAt = params.get("createdAt") != null
                    ? new SimpleDateFormat("yyyy-MM-dd").parse(params.get("createdAt").toString())
                    : new Date();

            Notice notice = new Notice();
            notice.setId(id);
            notice.setTitle(title);
            notice.setContent(content);
            notice.setCreatedAt(createdAt);

            boolean success;
            if (id == null) {
                success = noticeService.insert(notice);
            } else {
                success = noticeService.update(notice);
            }

            result.put("success", success);
            result.put("notice", notice);

        } catch (Exception e) {
            log.error("공지 저장 실패", e);
            result.put("success", false);
            result.put("message", "공지 저장 중 오류 발생");
        }
        return result;
    }

    /**
     * 공지 삭제
     * DELETE /admin/notices/{id}
     */
    @DeleteMapping("/{id}")
    public Map<String, Object> delete(@PathVariable("id") Long id) throws Exception {
        Map<String, Object> result = new HashMap<>();
        try {
            boolean success = noticeService.delete(id);
            result.put("success", success);
        } catch (Exception e) {
            log.error("공지 삭제 실패", e);
            result.put("success", false);
            result.put("message", "공지 삭제 중 오류 발생");
        }
        return result;
    }
}
