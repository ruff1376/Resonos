package com.cosmus.resonos.domain.admin;
import lombok.Data;

@Data
public class BadgeConditionRequest {
    private String name;
    private String description;
    private String iconUrl;
    private String conditionType;
    private Integer conditionValue;
}
