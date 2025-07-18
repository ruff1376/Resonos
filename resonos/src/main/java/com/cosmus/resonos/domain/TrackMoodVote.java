package com.cosmus.resonos.domain;

import lombok.Data;

@Data
public class TrackMoodVote {
    private Long id;
    private Long userId;
    private String trackId;
    private Long mood; // tag.id 참조
}