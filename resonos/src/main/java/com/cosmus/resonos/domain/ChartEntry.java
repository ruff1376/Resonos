package com.cosmus.resonos.domain;

import java.util.Date;
import lombok.Data;

@Data
public class ChartEntry {
    private Long id;
    private String type;
    private Integer rank;
    private Date calculatedAt;
    private String trackId;
}
