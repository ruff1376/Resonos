package com.cosmus.resonos.domain;

import java.util.Date;

public class UserBadgeLog {
    private Long id;
    private Long userId;
    private Long badgeId;
    private String action;      // 'GRANT', 'REVOKE', 'EXPIRE' 등
    private Long actorId;       // 관리자 or null(자동)
    private String reason;      
    private Date createdAt;

    // Getter, Setter
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    public Long getBadgeId() { return badgeId; }
    public void setBadgeId(Long badgeId) { this.badgeId = badgeId; }

    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }

    public Long getActorId() { return actorId; }
    public void setActorId(Long actorId) { this.actorId = actorId; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
