package com.cosmus.resonos.service.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.admin.Policy;

import java.util.Arrays;
import java.util.List;

@Service
public class UserInputService {

    @Autowired
    private PolicyService policyService;
    @Autowired
    private NotificationService notificationService;

    // public void handleUserInput(Long userId, String input, Long targetId) throws Exception {
    //     // 1. 금칙어 정책 조회
    //     Policy banwordPolicy = policyService.selectByType("banword");
    //     if (banwordPolicy == null) return; // 정책이 없으면 검사 패스

    //     // 2. 금칙어 리스트 파싱 (예: 콤마/세미콜론/JSON 등)
    //     List<String> banwords = parseBanwords(banwordPolicy.getContent());

    //     // 3. 입력값 검사
    //     for (String banword : banwords) {
    //         if (input != null && input.contains(banword)) {
    //             // 4. 위반 시 알림 자동 발송
    //             notificationService.createNotification(
    //                 userId,
    //                 "policy_violation",
    //                 "금칙어 사용 안내",
    //                 "입력하신 내용에 금칙어(" + banword + ")가 포함되어 있습니다.",
    //                 targetId
    //             );
    //             // 5. 예외 처리 또는 입력 차단
    //             throw new IllegalArgumentException("금칙어(" + banword + ")가 포함되어 있습니다.");
    //         }
    //     }
    //     // 6. 정상 입력 처리 로직 (예: DB 저장 등)
    // }

    // 금칙어 파싱 예시 (content가 "욕1,욕2,욕3" 형태일 때)
    private List<String> parseBanwords(String content) {
        if (content == null || content.trim().isEmpty()) return List.of();
        return Arrays.asList(content.split("\\s*,\\s*"));
    }
}
