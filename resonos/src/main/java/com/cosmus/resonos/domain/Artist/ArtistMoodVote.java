package com.cosmus.resonos.domain.Artist;

import lombok.Data;

@Data
public class ArtistMoodVote {
    private Long id;
    private Long userId;
    private String artistId;
    private Long mood;
}
