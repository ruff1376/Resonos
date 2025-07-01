package com.cosmus.resonos.domain;

import java.util.Date;
import lombok.Data;

@Data
public class UserFollow {
    private Long id;
    private Date createdAt;
    private Long followerId;
    private Long followingId;
}
