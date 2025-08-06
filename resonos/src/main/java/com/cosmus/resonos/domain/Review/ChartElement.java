package com.cosmus.resonos.domain.review;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import lombok.Data;

@Data
public class ChartElement {
    private Long id;
    private Long userId;

    @Min(0)
    @Max(100)
    private Integer lyric;

    @Min(0)
    @Max(100)
    private Integer sound;

    @Min(0)
    @Max(100)
    private Integer melody;

    @Min(0)
    @Max(100)
    private Integer storytelling;

    @Min(0)
    @Max(100)
    private Integer cohesiveness;

    @Min(0)
    @Max(100)
    private Integer creativity;

    private String albumId;
}
