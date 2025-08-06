package com.cosmus.resonos.domain.admin;

import java.util.Date;
import lombok.Data;

@Data
public class UserSanction {
    private Long id;
    private String type;
    private String reason;
    private Date startAt;
    private Date endAt;
    private Date createdAt;
    private Long userId;
    private Long adminId;
}
