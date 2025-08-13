package com.cosmus.resonos.service.badge;

import com.cosmus.resonos.domain.admin.UserActivitySummary;
import com.cosmus.resonos.domain.badge.BadgeCondition;

public interface BadgeConditionEvaluator {
    // 유저 배지 자동배급
    boolean isAchieved(UserActivitySummary summary, BadgeCondition condition);
    String getConditionType();
}