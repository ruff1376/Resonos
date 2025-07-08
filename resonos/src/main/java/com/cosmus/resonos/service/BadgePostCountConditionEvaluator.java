package com.cosmus.resonos.service;

import com.cosmus.resonos.domain.UserActivitySummary;
import com.cosmus.resonos.domain.BadgeCondition;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Service
@Component
public class BadgePostCountConditionEvaluator implements BadgeConditionEvaluator {
    @Override
    public boolean isAchieved(UserActivitySummary summary, BadgeCondition condition) {
        return summary.getPostCount() >= condition.getConditionValue();
    }
    @Override
    public String getConditionType() {
        return "POST_COUNT";
    }
}
