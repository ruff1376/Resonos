package com.cosmus.resonos.domain.admin;

import java.util.Date;
import lombok.Data;

@Data
public class Policy {
    private Long id;
    private String type;
    private String content;
    private String version;
    private Date updatedAt;
}
