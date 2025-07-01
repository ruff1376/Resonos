package com.cosmus.resonos.DTO;

import lombok.Data;

@Data
public class UserDTO {
    private Long id;
    private String username;
    private String email;
    private String password;
    private String nickname;
    private String profileImage;
    private String bio;
    private Boolean isPro;
    private Boolean enabled;
    private String provider;
    private String providerId;
    private java.sql.Timestamp createdAt;
}
