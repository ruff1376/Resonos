package com.cosmus.resonos.controller.admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.domain.admin.UserSanction;
import com.cosmus.resonos.service.admin.UserSanctionService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/user-sanctions")
public class UserSanctionController {

    @Autowired
    private UserSanctionService userSanctionService;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        log.info("[UserSanctionController] 제재 목록 요청");
        List<UserSanction> sanctions = userSanctionService.list();
        log.info("[UserSanctionController] 제재 수: {}", sanctions.size());
        model.addAttribute("sanctions", sanctions);
        return "usersanction/list"; // usersanction/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable Long id, Model model) throws Exception {
        log.info("[UserSanctionController] 제재 상세 요청 - id: {}", id);
        UserSanction sanction = userSanctionService.select(id);
        if (sanction == null) {
            log.warn("[UserSanctionController] 제재 없음 - id: {}", id);
            return "redirect:/user-sanctions?error=notfound";
        }
        log.info("[UserSanctionController] 제재 상세: {}", sanction);
        model.addAttribute("sanction", sanction);
        return "usersanction/detail"; // usersanction/detail.html
    }

    // 등록 폼
    @GetMapping("/new")
    public String create(Model model) {
        log.info("[UserSanctionController] 제재 등록 폼 요청");
        model.addAttribute("sanction", new UserSanction());
        return "usersanction/form"; // usersanction/form.html
    }

    // 등록 처리
    @PostMapping
    public String createPost(@ModelAttribute UserSanction sanction, Model model) throws Exception {
        log.info("[UserSanctionController] 제재 등록 시도: {}", sanction);
        boolean success = userSanctionService.insert(sanction);
        if (success) {
            log.info("[UserSanctionController] 제재 등록 성공: {}", sanction);
            return "redirect:/user-sanctions";
        }
        log.warn("[UserSanctionController] 제재 등록 실패: {}", sanction);
        model.addAttribute("error", "등록 실패");
        return "usersanction/form";
    }

    // 수정 폼
    @GetMapping("/{id}/edit")
    public String update(@PathVariable Long id, Model model) throws Exception {
        log.info("[UserSanctionController] 제재 수정 폼 요청 - id: {}", id);
        UserSanction sanction = userSanctionService.select(id);
        if (sanction == null) {
            log.warn("[UserSanctionController] 수정할 제재 없음 - id: {}", id);
            return "redirect:/user-sanctions?error=notfound";
        }
        model.addAttribute("sanction", sanction);
        return "usersanction/form";
    }

    // 수정 처리
    @PostMapping("/{id}/edit")
    public String updatePost(@PathVariable Long id, @ModelAttribute UserSanction sanction, Model model) throws Exception {
        log.info("[UserSanctionController] 제재 수정 시도 - id: {}, sanction: {}", id, sanction);
        sanction.setId(id);
        boolean success = userSanctionService.update(sanction);
        if (success) {
            log.info("[UserSanctionController] 제재 수정 성공 - id: {}", id);
            return "redirect:/user-sanctions/" + id;
        }
        log.warn("[UserSanctionController] 제재 수정 실패 - id: {}", id);
        model.addAttribute("error", "수정 실패");
        return "usersanction/form";
    }

    // 삭제 처리
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable Long id) throws Exception {
        log.info("[UserSanctionController] 제재 삭제 시도 - id: {}", id);
        userSanctionService.delete(id);
        log.info("[UserSanctionController] 제재 삭제 완료 - id: {}", id);
        return "redirect:/user-sanctions";
    }
}
