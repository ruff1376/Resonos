package com.cosmus.resonos.domain.admin;

import lombok.Data;
import java.util.Date;

@Data
public class Report {
    private Long id;
    private String targetType;      // ENUM
    private Long targetId;          // BIGINT
    private String reason;
    private String status;          // ENUM
    private Date createdAt;
    private Long reporterId;
    private Long processedBy;       // 관리자 ID
    private Date processedAt;
    private String processMemo;
}
