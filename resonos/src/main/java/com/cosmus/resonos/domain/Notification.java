package com.cosmus.resonos.domain;

import java.util.Date;
import lombok.Data;

@Data
public class Notification {
    private Long id;
    private String type;        // ENUM: 'comment', 'mention', 'like', 'follow', 'reply', 'badge', 'qna', 'announcement', 'system'
    private String message;
    private String content;
    private Boolean isRead;
    private Date createdAt;
    private String targetId;
    private Long userId;
}
