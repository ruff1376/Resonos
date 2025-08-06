package com.cosmus.resonos.domain.admin;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;

@Getter
@Builder
@Data
public class UserActivitySummary {
    private final Long userId;
    private final int postCount;
    private final int commentCount;
    private final int followerCount;
}