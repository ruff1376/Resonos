package com.cosmus.resonos.domain.user;

import java.util.Date;
import java.util.List;

import com.cosmus.resonos.domain.review.Track;
import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@lombok.Builder
public class Playlist {
    private Long id;
    private Long userId;
    private String title;
    private String description;
    private String thumbnailUrl;
    private Boolean isPublic;
    private Date createdAt;
    private String trackId;
    private int likeCount;
    private String maker;
    private String ownerName;
    // 플레이리스트 제이슨 변경시 무시
    @JsonIgnore
    List<Track> trackList;
}
