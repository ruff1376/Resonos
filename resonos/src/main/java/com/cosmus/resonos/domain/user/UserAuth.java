package com.cosmus.resonos.domain.user;

import lombok.Data;

@Data
public class UserAuth {
    private Long no;
    private String username;
    private String auth;
}
