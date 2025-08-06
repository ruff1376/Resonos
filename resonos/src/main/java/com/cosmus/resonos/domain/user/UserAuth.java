package com.cosmus.resonos.domain.user;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class UserAuth {
    private Long no;
    private String username;
    private String auth;

    public UserAuth(String username, String auth) {
        this.username = username;
        this.auth = auth;
    }
}
