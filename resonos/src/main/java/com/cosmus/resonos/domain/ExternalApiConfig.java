package com.cosmus.resonos.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ExternalApiConfig {
    private Long id;
    private String provider;
    private String apiKey;
    private String secret;
    private Boolean enabled;
    private Date createdAt;
}
