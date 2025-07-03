package com.cosmus.resonos.domain;

import lombok.Data;

@Data
public class Track {
    private String id;
    private String title;
    private int duration;
    private String genre;
    private String streamingUrl;
    private String mvUrl;
    private String albumId;
    private String artistId;
    private int popularity;
    private int trackNo;
    private String artistName;
    private String coverImage;
}
