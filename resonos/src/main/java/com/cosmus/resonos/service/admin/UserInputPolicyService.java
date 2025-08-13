package com.cosmus.resonos.service.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.admin.Policy;

import java.util.Arrays;
import java.util.List;

@Service
public class UserInputPolicyService {

    @Autowired
    private PolicyService policyService;
    @Autowired
    private NotificationService notificationService;

    /**
     * 입력값에 금칙어 정책 위반 여부를 검사하고, 위반 시 알림을 발송한다.
     * 위반 시 IllegalArgumentException 발생
     */
    // public void checkBanwordAndNotify(Long userId, String input, Long targetId) throws Exception {
    //     Policy banwordPolicy = policyService.selectByType("banword");
    //     if (banwordPolicy == null) return;
    //     List<String> banwords = parseBanwords(banwordPolicy.getContent());
    //     for (String banword : banwords) {
    //         if (input != null && input.contains(banword)) {
    //             notificationService.createPolicyViolationNotification(userId, banword, targetId);
    //             throw new IllegalArgumentException("금칙어(" + banword + ")가 포함되어 있습니다.");
    //         }
    //     }
    // }

    // // 금칙어 리스트 파싱 (예: "욕1,욕2,욕3" 형태)
    // private List<String> parseBanwords(String content) {
    //     if (content == null || content.trim().isEmpty()) return List.of();
    //     return Arrays.asList(content.split("\\s*,\\s*"));
    // }
}
