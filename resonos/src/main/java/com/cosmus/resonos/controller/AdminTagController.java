package com.cosmus.resonos.controller;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.Vote.Tag;
import com.cosmus.resonos.service.TagService;

@Controller
@RequestMapping("/admin/tags")
public class AdminTagController {

    @Autowired
    private TagService tagService;

    // 페이징 처리된 태그 목록 페이지
    @GetMapping
    public String list(
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size,
            @RequestParam(value = "keyword", required = false) String keyword,
            Model model) throws Exception {
        
        if (page < 1) page = 1;
        if (size < 1) size = 10;
        if (keyword == null) keyword = "";

        try {
            // 전체 태그 개수 조회 (검색 키워드 반영)
            long total = (!keyword.isBlank()) ? tagService.countByKeyword(keyword) : tagService.countAll();

            // 페이징 객체 생성 (현재 페이지, 페이지 크기, 페이지 링크 개수, 전체 개수)
            Pagination pagination = new Pagination(page, size, 10, total);

            // 페이징 적용된 태그 리스트 조회
            List<Tag> tags = (!keyword.isBlank())
                    ? tagService.searchByNamePaging(keyword, pagination.getIndex(), pagination.getSize())
                    : tagService.listPaging(pagination.getIndex(), pagination.getSize());

            model.addAttribute("tags", tags);
            model.addAttribute("pagination", pagination);
            model.addAttribute("keyword", keyword);

            // 페이징 링크용 URI 생성 (size, keyword 유지)
            String pageUri = "/admin/tags?size=" + size;
            if (!keyword.isBlank()) {
                pageUri += "&keyword=" + URLEncoder.encode(keyword, StandardCharsets.UTF_8);
            }
            model.addAttribute("pageUri", pageUri);

        } catch (Exception e) {
            model.addAttribute("errorMessage", "태그 목록 조회 중 오류가 발생했습니다.");
            model.addAttribute("tags", List.of());
            model.addAttribute("pagination", new Pagination(1, size, 10, 0));
            model.addAttribute("keyword", keyword);
            model.addAttribute("pageUri", "/admin/tags");
        }

        return "admin/tags"; // thymeleaf template path
    }

    // 태그 등록 처리
    @PostMapping("/add")
    public String add(@RequestParam("name") String name) throws Exception {
        Tag tag = new Tag();
        tag.setName(name);
        tagService.insert(tag);
        return "redirect:/admin/tags";
    }

    // 태그 수정 폼
    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable("id") Long id, Model model) throws Exception {
        Tag tag = tagService.select(id);
        if (tag == null) {
            return "redirect:/admin/tags?error=notfound";
        }
        model.addAttribute("tag", tag);
        return "admin/tags";
    }

    // 태그 수정 처리
    @PostMapping("/{id}/edit")
    public String edit(@PathVariable("id") Long id, @RequestParam("name") String name) throws Exception {
        Tag tag = new Tag();
        tag.setId(id);
        tag.setName(name);
        tagService.update(tag);
        return "redirect:/admin/tags";
    }

    // 태그 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable("id") Long id) throws Exception {
        tagService.delete(id);
        return "redirect:/admin/tags";
    }

    // 단일 검색 (Ajax 용)
    @GetMapping("/search")
    @ResponseBody
    public List<Tag> search(@RequestParam("keyword") String keyword) {
        return tagService.searchByName(keyword);
    }
}
