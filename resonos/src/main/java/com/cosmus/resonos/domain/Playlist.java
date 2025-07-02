package com.cosmus.resonos.domain;

import java.util.Date;
import lombok.Data;

@Data
public class Playlist {
    private Long id;
    private Long userId;
    private String title;
    private String description;
    private String thumbnailUrl;
    private Boolean isPublic;
    private Date createdAt;
    private String trackId;
}
