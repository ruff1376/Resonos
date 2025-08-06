package com.cosmus.resonos.domain.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PublicUserDto {

  private Long id;
  private String nickname;
  private String profileImage;
  private String bio;
  private Long currentBadge;
}
