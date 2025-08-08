package com.cosmus.resonos.validation;

import lombok.Data;

@Data
public class ReviewForm {

    private Long id;

    /** 0‒100 점 */
    private Integer rating;

    /** 리뷰 본문 */
    private String content;
}
