package com.cosmus.resonos.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@lombok.Builder
public class Playlist {
    private Long id;
    private Long userId;
    private String title;
    private String description;
    private String thumbnailUrl;
    private Boolean isPublic;
    private Date createdAt;
    private String trackId;
    private int likeCount;
}
