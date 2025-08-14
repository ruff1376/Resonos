package com.cosmus.resonos.domain.community;

import java.util.Date;

import lombok.Data;

@Data
public class LikesDislikes {
    private Long id;
    private String type;    // 'post', 'comment'
    private Long userId;
    private boolean isLikes;
    private Long targetId;
    private Date createdAt;
}
