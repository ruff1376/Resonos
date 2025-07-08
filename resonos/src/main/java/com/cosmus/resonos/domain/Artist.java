package com.cosmus.resonos.domain;

import lombok.Data;

@Data
public class Artist {
    private String id;
    private String name;
    private String profileImage;
    private String genres;
    private int followerCount;
}
