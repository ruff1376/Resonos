package com.cosmus.resonos.service;

import com.cosmus.resonos.domain.UserActivitySummary;
import com.cosmus.resonos.domain.BadgeCondition;

public interface BadgeConditionEvaluator {
    // 유저 배지 자동배급
    boolean isAchieved(UserActivitySummary summary, BadgeCondition condition);
    String getConditionType();
}