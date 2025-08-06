package com.cosmus.resonos.service.badge;

import com.cosmus.resonos.domain.admin.BadgeCondition;
import com.cosmus.resonos.domain.user.UserActivitySummary;

public interface BadgeConditionEvaluator {
    // 유저 배지 자동배급
    boolean isAchieved(UserActivitySummary summary, BadgeCondition condition);
    String getConditionType();
}