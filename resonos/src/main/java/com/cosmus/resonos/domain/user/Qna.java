package com.cosmus.resonos.domain.user;

import java.util.Date;
import lombok.Data;

@Data
public class Qna {
    private Long id;
    private String type;
    private String title;
    private String content;
    private Date createdAt;
    private Boolean status;
    private Long userId;
}
