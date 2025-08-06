package com.cosmus.resonos.domain.user;

import java.util.Date;
import lombok.Data;

@Data
public class UserRole {
    private Long id;
    private Date assignedAt;
    private Long userId;
    private Long roleId;
}
