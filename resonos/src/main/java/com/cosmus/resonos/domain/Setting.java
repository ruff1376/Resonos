package com.cosmus.resonos.domain;

import java.util.Date;
import lombok.Data;

@Data
public class Setting {
    private Long id;
    private String value;
    private Date updatedAt;
}
