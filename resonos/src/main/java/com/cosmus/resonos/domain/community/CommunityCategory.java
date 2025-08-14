package com.cosmus.resonos.domain.community;

import java.util.Date;

import lombok.Data;

@Data
public class CommunityCategory {
    private Long id;
    private boolean isKor;
    private String name;
    private Date createdAt;
}
