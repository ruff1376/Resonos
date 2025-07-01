package com.cosmus.resonos.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Album {
    private String id;
    private String title;
    private String coverImage;
    private Date releaseDate;
    private String genre;
    private String label;
    private String description;
    private String artistId;
}
