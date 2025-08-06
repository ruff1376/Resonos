package com.cosmus.resonos.domain.user;

import java.util.Date;
import lombok.Data;

@Data
public class LikedPlaylist {
    private Long id;
    private Date createdAt;
    private Long userId;
    private String playlistId;
}
