package com.cosmus.resonos.domain.admin;

import java.util.Date;
import lombok.Data;

@Data
public class Setting {
    private Long id;
    private String name;
    private String description;
    private String value;
    private Date updatedAt;
    private Date createdAt;
}

