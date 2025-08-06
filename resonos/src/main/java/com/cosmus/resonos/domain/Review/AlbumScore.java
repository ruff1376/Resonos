package com.cosmus.resonos.domain.review;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AlbumScore {
    /** FK – album.id */
    private String albumId;
    /** 평균 점수 (소수점 버림) */
    private Double averageScore;
    /** critic = true 인 리뷰 수 */
    private Integer criticCount;
    /** critic = false 인 리뷰 수 */
    private Integer userCount;
}