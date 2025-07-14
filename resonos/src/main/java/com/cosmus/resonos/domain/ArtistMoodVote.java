package com.cosmus.resonos.domain;

import lombok.Data;

@Data
public class ArtistMoodVote {
    private Long id;
    private Long userId;
    private String artistId;
    private Long mood;
}
