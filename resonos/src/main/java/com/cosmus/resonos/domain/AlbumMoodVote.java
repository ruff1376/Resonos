package com.cosmus.resonos.domain;

import lombok.Data;

@Data
public class AlbumMoodVote {
    private Long id;
    private Long userId;
    private String albumId;
    private Long mood;
}
