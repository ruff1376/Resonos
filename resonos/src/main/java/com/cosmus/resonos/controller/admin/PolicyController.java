package com.cosmus.resonos.controller.admin;
// package com.cosmus.resonos.controller;

// import java.util.List;
// import java.util.Map;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Controller;
// import org.springframework.ui.Model;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.ModelAttribute;
// import org.springframework.web.bind.annotation.PathVariable;
// import org.springframework.web.bind.annotation.PostMapping;
// import org.springframework.web.bind.annotation.RequestMapping;
// import org.springframework.web.bind.annotation.RequestParam;

// import com.cosmus.resonos.domain.Policy;
// import com.cosmus.resonos.domain.Setting;
// import com.cosmus.resonos.service.PolicyService;
// import com.cosmus.resonos.service.SettingService;

// import groovy.util.logging.Slf4j;

// @Slf4j
// @Controller
// @RequestMapping("/admin/PolicySetting")
// public class PolicyController {

//     @Autowired
//     private PolicyService policyService;

//     @Autowired
//     private SettingService settingService;


//     // 상세
//     @GetMapping("/{id}")
//     public String detail(@PathVariable("id") Long id, Model model) throws Exception {
//         Policy policy = policyService.select(id);
//         if (policy == null) return "redirect:/admin/PolicySetting?error=notfound";
//         model.addAttribute("policy", policy);
//         return "/admin/PolicySetting"; // policy/detail.html
//     }

//     // 등록 폼
//     @GetMapping("/create")
//     public String create(Model model) {
//         model.addAttribute("policy", new Policy());
//         return "/admin/PolicySetting"; // policy/form.html
//     }

//     // 등록 처리
//     @PostMapping("/create")
//     public String createPost(@ModelAttribute Policy policy, Model model) throws Exception {
//         boolean success = policyService.insert(policy);
//         if (success) {
//             return "redirect:/admin/PolicySetting";
//         }
//         model.addAttribute("error", "등록 실패");
//         return "/admin/PolicySetting";
//     }


//     // 수정 폼
//     @GetMapping("/update/{id}")
//     public String update(@PathVariable("id") Long id, Model model) throws Exception {
//         Policy policy = policyService.select(id);
//         if (policy == null) return "redirect:/policies?error=notfound";
//         model.addAttribute("policy", policy);
//         return "/admin/PolicySetting";
//     }

//     // 수정 처리
//     @PostMapping("/update/{id}")
//     public String updatePost(@PathVariable("id") Long id, @ModelAttribute Policy policy, Model model) throws Exception {
//         policy.setId(id);
//         if (policyService.update(policy)) return "redirect:/admin/PolicySetting";
//         model.addAttribute("error", "수정 실패");
//         return "/admin/PolicySetting";
//     }

//     // 삭제
//     @PostMapping("/delete/{id}")
//     public String delete(@PathVariable("id") Long id) throws Exception {
//         policyService.delete(id);
//         return "redirect:/admin/PolicySetting";
//     }

//     // 환경설정 저장
//     @PostMapping("/setting/save")
//     public String saveSetting(
//             @RequestParam(value = "allowSignUp", required = false) String allowSignUp,
//             @RequestParam(value = "enableCommunity", required = false) String enableCommunity,
//             @RequestParam(value = "externalMusicApi", required = false) String externalMusicApi,
//             @RequestParam(value = "theme", required = false) String theme,
//             @RequestParam(value = "notice", required = false) String notice
//     ) throws Exception {
//         // id로 구분, 각 항목은 id(숫자)로 관리, value에 값만 저장
//         saveOrUpdateSetting(1L, allowSignUp != null ? "Y" : "N");
//         saveOrUpdateSetting(2L, enableCommunity != null ? "Y" : "N");
//         saveOrUpdateSetting(3L, externalMusicApi != null ? "Y" : "N");
//         saveOrUpdateSetting(4L, theme != null ? theme : "dark");
//         saveOrUpdateSetting(5L, notice != null ? notice : "");
//         return "redirect:/admin/PolicySetting";
//     }

//     // id로 환경설정 저장/수정 (없으면 insert, 있으면 update)
//     private void saveOrUpdateSetting(Long id, String value) throws Exception {
//         Setting setting = settingService.select(id);
//         if (setting == null) {
//             setting = new Setting();
//             setting.setId(id);
//             setting.setValue(value);
//             settingService.insert(setting);
//         } else {
//             setting.setValue(value);
//             settingService.update(setting);
//         }
//     }

// }

