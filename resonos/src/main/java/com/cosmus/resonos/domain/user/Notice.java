package com.cosmus.resonos.domain.user;

import java.util.Date;

import lombok.Data;

@Data
public class Notice {
    private Long id;
    private String title;
    private String content;
    private Date createdAt;
    private Date updatedAt;
    private Boolean isActive;
    private Date startAt;
    private Date endAt;
    private Long authorId;
}
