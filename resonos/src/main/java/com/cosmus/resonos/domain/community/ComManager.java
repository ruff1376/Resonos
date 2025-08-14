package com.cosmus.resonos.domain.community;

import java.util.Date;

import lombok.Data;

@Data
public class ComManager {
    private Long id;
    private Long userId;
    private Long comId;
    private Date createdAt;
}
