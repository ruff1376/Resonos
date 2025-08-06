package com.cosmus.resonos.domain.user;

import java.util.Date;
import java.util.List;

import com.cosmus.resonos.domain.Track.Track;

import groovy.transform.builder.Builder;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PlaylistDTO {
  private Long id;
  private Long userId;
  private String title;
  private String description;
  private String thumbnailUrl;
  private Boolean isPublic;
  private Date createdAt;

  List<Track> trackList;
}
