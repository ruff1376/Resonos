package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Tag;
import com.cosmus.resonos.service.TagService;

@Controller
@RequestMapping("/admin/tags")
public class AdminTagController {

    @Autowired
    private TagService tagService;

    // 태그 목록 페이지
    @GetMapping
    public String list(Model model) throws Exception {
        List<Tag> tags = tagService.list();
        model.addAttribute("tags", tags);
        return "admin/tags"; // templates/admin/tags.html
    }

    // 태그 등록 처리 (폼에서 POST)
    @PostMapping("/add")
    public String add(@RequestParam("name") String name) throws Exception {
        Tag tag = new Tag();
        tag.setName(name);
        tagService.insert(tag);
        return "redirect:/admin/tags";
    }

    // 태그 수정 폼
    @GetMapping("/{id}/edit")
    public String editForm(@PathVariable Long id, Model model) throws Exception {
        Tag tag = tagService.select(id);
        if (tag == null) {
            return "redirect:/admin/tags?error=notfound";
        }
        model.addAttribute("tag", tag);
        return "admin/tags"; 
    }

    // 태그 수정 처리
    @PostMapping("/{id}/edit")
    public String edit(@PathVariable Long id, @RequestParam("name") String name) throws Exception {
        Tag tag = new Tag();
        tag.setId(id);
        tag.setName(name);
        tagService.update(tag);
        return "redirect:/admin/tags";
    }

    // 태그 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        tagService.delete(id);
        return "redirect:/admin/tags";
    }

    // 검색기능 
    @GetMapping("/search")
    @ResponseBody
    public List<Tag> search(@RequestParam String keyword) {
        return tagService.searchByName(keyword);
    }


}
