package com.cosmus.resonos.domain.badge;

import java.util.Date;
import lombok.Data;

@Data
public class UserBadge {
    private Long id;
    private Date createdAt;
    private Long userId;
    private Long badgeId;
}
