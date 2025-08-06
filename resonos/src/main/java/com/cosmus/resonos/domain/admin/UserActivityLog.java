package com.cosmus.resonos.domain.admin;

import java.util.Date;
import lombok.Data;

@Data
public class UserActivityLog {
    private Long id;
    private String action;
    private String targetType;
    private Long targetId;
    private String detail;
    private String ipAddress;
    private String userAgent;
    private Date createdAt;
    private Long userId;
}
