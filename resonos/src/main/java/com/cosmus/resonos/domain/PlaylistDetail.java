package com.cosmus.resonos.domain;

import lombok.Data;

@Data
public class PlaylistDetail {
    private Long id;
    private String trackId;
    private Long playlistId;
    private Integer orderNo;
    private String field; // 컬럼명이 대소문자 구분될 경우 주의 (MySQL은 소문자, Java는 camelCase)
}
