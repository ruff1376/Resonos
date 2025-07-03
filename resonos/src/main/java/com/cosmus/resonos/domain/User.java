package com.cosmus.resonos.domain;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {
    private Long id;
    private String username;
    private String email;
    private String password;
    private String nickname;
    private String profileImage;
    private String bio;
    private boolean isPro;
    private boolean enabled;
    private String provider;
    private String provider_id;
    private Date createdAt;

    private List<UserAuth> authList;
}
