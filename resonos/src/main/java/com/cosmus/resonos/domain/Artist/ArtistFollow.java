package com.cosmus.resonos.domain.Artist;

import java.util.Date;
import lombok.Data;

@Data
public class ArtistFollow {
    private Long id;
    private Date createdAt;
    private Long userId;
    private String artistId;
}
