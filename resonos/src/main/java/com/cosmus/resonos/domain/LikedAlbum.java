package com.cosmus.resonos.domain;

import java.time.LocalDateTime;
import java.util.Date;
import lombok.Data;

@Data
public class LikedAlbum {
    private Long id;
    private Date createdAt;
    private Long userId;
    private String albumId;
}
