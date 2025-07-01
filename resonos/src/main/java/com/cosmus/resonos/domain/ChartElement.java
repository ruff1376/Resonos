package com.cosmus.resonos.domain;

import lombok.Data;

@Data
public class ChartElement {
    private Long id;
    private Integer lyric;
    private Integer sound;
    private Integer melody;
    private Integer storytelling;
    private Integer cohesiveness;
    private Integer creativity;
    private String albumId;
}
