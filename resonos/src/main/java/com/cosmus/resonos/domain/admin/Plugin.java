package com.cosmus.resonos.domain.admin;

import java.util.Date;
import lombok.Data;

@Data
public class Plugin {
    private Long id;
    private String name;
    private Boolean enabled;
    private String configJson;
    private Date createdAt;
}
