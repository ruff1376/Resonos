package com.cosmus.resonos.domain.community;

import java.util.Date;
import lombok.Data;

@Data
public class Community {
    private Long id;
    private Long categoryId;
    private Long creatorId;
    private String name;
    private String description;
    private Date createdAt;
}
