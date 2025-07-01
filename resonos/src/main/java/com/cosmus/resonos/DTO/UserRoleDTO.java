package com.cosmus.resonos.DTO;

import lombok.Data;

@Data
public class UserRoleDTO {
    private Long id;
    private java.sql.Timestamp assignedAt;
    private Long userId;
    private Long roleId;
}
