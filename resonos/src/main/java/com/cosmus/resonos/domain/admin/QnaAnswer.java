package com.cosmus.resonos.domain.admin;

import java.util.Date;
import lombok.Data;

@Data
public class QnaAnswer {
    private Long id;
    private String content;
    private Date answeredAt;
    private Long qnaId;
    private Long adminId;
}
