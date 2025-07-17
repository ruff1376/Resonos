package com.cosmus.resonos.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ConcertInfo {
    private String date;       // 공연 날짜
    private String country;    // 국가명
    private String displayName; // 공연 이름
}
