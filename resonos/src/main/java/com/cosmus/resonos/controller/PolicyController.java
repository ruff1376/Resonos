package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosmus.resonos.domain.Policy;
import com.cosmus.resonos.service.PolicyService;

@Controller
@RequestMapping("/admin/PolicySetting")
public class PolicyController {

    @Autowired
    private PolicyService policyService;

    // 목록
    @GetMapping
    public String list(Model model) throws Exception {
        List<Policy> policies = policyService.list();
        model.addAttribute("policies", policies);
        return "/admin/PolicySetting"; // policy/list.html
    }

    // 상세
    @GetMapping("/{id}")
    public String detail(@PathVariable("id") Long id, Model model) throws Exception {
        Policy policy = policyService.select(id);
        if (policy == null) return "redirect:/admin/PolicySetting?error=notfound";
        model.addAttribute("policy", policy);
        return "/admin/PolicySetting"; // policy/detail.html
    }

    // 등록 폼
    @GetMapping("/create")
    public String create(Model model) {
        model.addAttribute("policy", new Policy());
        return "/admin/PolicySetting"; // policy/form.html
    }

    // 등록 처리
    @PostMapping("/create")
    public String createPost(@ModelAttribute Policy policy, Model model) throws Exception {
        boolean success = policyService.insert(policy);
        if (success) {
            return "redirect:/admin/PolicySetting";
        }
        model.addAttribute("error", "등록 실패");
        return "/admin/PolicySetting";
    }


    // 수정 폼
    @GetMapping("/update/{id}")
    public String update(@PathVariable("id") Long id, Model model) throws Exception {
        Policy policy = policyService.select(id);
        if (policy == null) return "redirect:/policies?error=notfound";
        model.addAttribute("policy", policy);
        return "/admin/PolicySetting";
    }

    // 수정 처리
    @PostMapping("/update/{id}")
    public String updatePost(@PathVariable("id") Long id, @ModelAttribute Policy policy, Model model) throws Exception {
        policy.setId(id);
        if (policyService.update(policy)) return "redirect:/admin/PolicySetting";
        model.addAttribute("error", "수정 실패");
        return "/admin/PolicySetting";
    }

    // 삭제
    @PostMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id) throws Exception {
        policyService.delete(id);
        return "redirect:/admin/PolicySetting";
    }

}

