package com.cosmus.resonos.domain.admin;

import java.util.Date;
import lombok.Data;

@Data
public class Badge {
    private Long id;
    private String name;
    private String description;
    private String iconUrl;
    private String criteria;
    private Date createdAt;
}
