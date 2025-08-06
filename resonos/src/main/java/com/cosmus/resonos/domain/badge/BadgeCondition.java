package com.cosmus.resonos.domain.badge;

import lombok.Data;

@Data
public class BadgeCondition {
    private Long id;                 // 조건 고유 번호
    private Long badgeId;            // 배지 고유 번호
    private String badgeName;       // 배지 이름 (오타 주의: badgeName 추
    private String description;      // 배지 설명
    private String conditionType;    // 조건 유형
    private int conditionValue;  // 조건 값

    // Getter/Setter
}
