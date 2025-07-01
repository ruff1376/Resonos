package com.cosmus.resonos.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Artist {
    private String id;
    private Date createdAt;
    private String userId;
    private String artistId;
}
