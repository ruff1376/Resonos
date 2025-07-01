package com.cosmus.resonos.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.Community;
import com.cosmus.resonos.service.CommunityService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/communities")
public class CommunityController {

    @Autowired
    private CommunityService communityService;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[CommunityController] 커뮤니티 목록 요청");
        List<Community> communities = communityService.list();
        log.info("[CommunityController] 커뮤니티 수: {}", communities.size());
        model.addAttribute("communities", communities);
        return "community/list"; // community/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[CommunityController] 커뮤니티 상세 요청 - id: {}", id);
        Community community = communityService.select(id);
        if (community == null) {
            log.warn("[CommunityController] 커뮤니티 없음 - id: {}", id);
            return "redirect:/communities?error=notfound";
        }
        log.info("[CommunityController] 커뮤니티 상세: {}", community);
        model.addAttribute("community", community);
        return "community/detail"; // community/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[CommunityController] 커뮤니티 등록 폼 요청");
        model.addAttribute("community", new Community());
        return "community/form"; // community/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute Community community, Model model) throws Exception {
        log.info("[CommunityController] 커뮤니티 등록 시도: {}", community);
        boolean success = communityService.insert(community);
        if (success) {
            log.info("[CommunityController] 커뮤니티 등록 성공: {}", community);
            return "redirect:/communities";
        }
        log.warn("[CommunityController] 커뮤니티 등록 실패: {}", community);
        model.addAttribute("error", "등록 실패");
        return "community/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[CommunityController] 커뮤니티 수정 폼 요청 - id: {}", id);
        Community community = communityService.select(id);
        if (community == null) {
            log.warn("[CommunityController] 수정할 커뮤니티 없음 - id: {}", id);
            return "redirect:/communities?error=notfound";
        }
        model.addAttribute("community", community);
        return "community/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute Community community, Model model) throws Exception {
        log.info("[CommunityController] 커뮤니티 수정 시도 - id: {}, community: {}", id, community);
        community.setId(id);
        boolean success = communityService.update(community);
        if (success) {
            log.info("[CommunityController] 커뮤니티 수정 성공 - id: {}", id);
            return "redirect:/communities/" + id;
        }
        log.warn("[CommunityController] 커뮤니티 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "community/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[CommunityController] 커뮤니티 삭제 시도 - id: {}", id);
        communityService.delete(id);
        log.info("[CommunityController] 커뮤니티 삭제 완료 - id: {}", id);
        return "redirect:/communities";
    }
}
