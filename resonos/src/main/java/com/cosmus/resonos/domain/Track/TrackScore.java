package com.cosmus.resonos.domain.Track;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class TrackScore {
    /** FK – track.id */
    private String trackId;
    /** 평균 점수 (소수점 버림) */
    private Double averageScore;
    /** critic = true 인 리뷰 수 */
    private Integer criticCount;
    /** critic = false 인 리뷰 수 */
    private Integer userCount;
}