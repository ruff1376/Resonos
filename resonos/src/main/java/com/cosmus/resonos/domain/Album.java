package com.cosmus.resonos.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class Album {
    private String id;
    private String title;
    private String coverImage;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date releaseDate;
    private String genre;
    private String label;
    private String description;
    private String artistId;
    private String artistName;
}
