package com.cosmus.resonos.domain;
import java.util.Date;
import lombok.Data;

@Data
public class AdminLog {
    private Long id;
    private String action;
    private String targetType;
    private String meta;         // JSON은 String으로 매핑 (MyBatis에서 직접 파싱하지 않으면)
    private String reason;
    private String description;
    private String ipAddress;
    private String userAgent;
    private Date createdAt;
    private Long actorId;
    private Long targetId;
}
