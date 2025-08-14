package com.cosmus.resonos.domain.community;

import java.util.Date;
import lombok.Data;

@Data
public class Comment {
    private Long id;
    private String content;
    private Date createdAt;
    private Long userId;
    private String type;    // 'posts', 'playlist', 'comment'
    private Long targetId;
    private Long boardPostId;
    private Long parentCommentId;
}
