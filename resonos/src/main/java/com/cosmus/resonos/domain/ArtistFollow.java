package com.cosmus.resonos.domain;

import java.util.Date;
import lombok.Data;

@Data
public class ArtistFollow {
    private String id;
    private Date createdAt;
    private Long userId;
    private String artistId;
}
