package com.cosmus.resonos.DTO;

import lombok.Data;

@Data
public class UserSanctionDTO {
    private Long id;
    private String type;
    private String reason;
    private java.sql.Timestamp startAt;
    private java.sql.Timestamp endAt;
    private java.sql.Timestamp createdAt;
    private Long userId;
    private Long adminId;
}
