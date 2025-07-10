package com.cosmus.resonos.domain;

import java.time.LocalDateTime;

import groovy.transform.builder.Builder;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ReviewReport {
    private Long id;
    private Long reviewId;
    private Long userId;
    private String reviewType;
    private LocalDateTime createdAt;
}