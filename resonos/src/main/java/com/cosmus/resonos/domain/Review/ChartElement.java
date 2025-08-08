package com.cosmus.resonos.domain.review;

import lombok.Data;

@Data
public class ChartElement {
    private Long id;
    private Long userId;

    private Integer lyric;

    private Integer sound;

    private Integer melody;

    private Integer storytelling;

    private Integer cohesiveness;

    private Integer creativity;

    private String albumId;
}
