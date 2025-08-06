package com.cosmus.resonos.domain.Review;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reviewer {
    private Long id;
    private String nickname;
    private String profileImage;
    private boolean isPro;
}