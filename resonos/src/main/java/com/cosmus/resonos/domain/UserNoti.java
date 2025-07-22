package com.cosmus.resonos.domain;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
public class UserNoti {

  private Long userId;
  private String type;
  private Boolean isEnabled;
}
