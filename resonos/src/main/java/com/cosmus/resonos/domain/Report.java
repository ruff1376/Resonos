package com.cosmus.resonos.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Report {
    private Long id;
    private String targetType;  // ENUM 대신 String으로 매핑
    private String reason;
    private String status;
    private Date createdAt;
    private Long reporterId;
    private Long targetId;
}