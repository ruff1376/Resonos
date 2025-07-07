package com.cosmus.resonos.util;

import java.util.Random;

public class RandomPassword {

  public static String generateRandomPassword(int length) {
    String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    StringBuilder sb = new StringBuilder();
    Random rnd = new Random();
    for (int i = 0; i < length; i++) {
        sb.append(chars.charAt(rnd.nextInt(chars.length())));
    }
    return sb.toString();
  }
}
