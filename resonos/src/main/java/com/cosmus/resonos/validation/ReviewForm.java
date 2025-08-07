package com.cosmus.resonos.validation;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class ReviewForm {

    private Long id;

    /** 0‒100 점 */
    @Min(0) @Max(100)
    private Integer rating;

    /** 리뷰 본문 */
    @NotBlank
    private String content;
}
