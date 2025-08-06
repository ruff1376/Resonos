package com.cosmus.resonos.domain.community;

import java.util.Date;
import lombok.Data;

@Data
public class Community {
    private Long id;
    private String name;
    private String description;
    private Date createdAt;
    private Long creatorId;
}
