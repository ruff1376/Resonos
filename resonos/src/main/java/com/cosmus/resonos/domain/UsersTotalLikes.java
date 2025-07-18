package com.cosmus.resonos.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UsersTotalLikes {

  private int trackLikes;
  private int albumLikes;
  private int totalLikes;
}
