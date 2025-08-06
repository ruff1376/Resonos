package com.cosmus.resonos.domain.review;

import java.util.Date;
import lombok.Data;

@Data
public class LikedTrack {
    private Long id;
    private Date createdAt;
    private Long userId;
    private String trackId;
}
