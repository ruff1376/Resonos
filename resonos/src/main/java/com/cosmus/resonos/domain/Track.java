package com.cosmus.resonos.domain;

import java.util.Date;

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
    private int orderNo;
    private Date releaseDate;
    private int likeCount;
    private int followerCount;
    private int popularityScore;

    public String getFormattedDuration() {
        int minutes = duration / 60;
        int seconds = duration % 60;
        return String.format("%d:%02d", minutes, seconds);
    }
}
