package com.cosmus.resonos.domain.review;

import lombok.Data;

@Data
public class MoodStat {

    private String moodName;
    private int voteCount;

    // 필요한 경우 백분율 계산용 필드도 추가 가능
}