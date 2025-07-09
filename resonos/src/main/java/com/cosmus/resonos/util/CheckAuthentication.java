package com.cosmus.resonos.util;

public class CheckAuthentication {

  public static boolean isOwner(Long userId, Long loginId) {
    return userId.equals(loginId);
  }
}
