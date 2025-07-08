package com.cosmus.resonos.util;

import java.io.File;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

import com.cosmus.resonos.domain.Playlist;
import com.cosmus.resonos.domain.Users;

public class UploadImage {

  public static void uploadProfileImage(MultipartFile file, Users user) {
    try {
      String uploadDir = System.getProperty("user.dir") + "/resonos/uploads/profile_img";

      File folder = new File(uploadDir);
      if (!folder.exists()) {
          folder.mkdirs(); // 폴더 없으면 생성
      }

      System.out.println(System.getProperty("user.dir"));

      // 파일 이름 중복 방지용
      String originalFilename = file.getOriginalFilename();
      String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
      String savedFilename = UUID.randomUUID() + extension;

      String savePath = new File(uploadDir, savedFilename).getAbsolutePath();

      // 저장
      file.transferTo(new File(savePath));

      user.setProfileImage("/profile_img/" + savedFilename);

    } catch(Exception e) {
          e.printStackTrace();
      }
  }

  public static void uploadThumbnailImage(MultipartFile file, Playlist playlist) {
    try {
      String uploadDir = System.getProperty("user.dir") + "/resonos/uploads/thumbnail";

      File folder = new File(uploadDir);
      if (!folder.exists()) {
          folder.mkdirs(); // 폴더 없으면 생성
      }

      // 파일 이름 중복 방지용
      String originalFilename = file.getOriginalFilename();
      String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
      String savedFilename = UUID.randomUUID() + extension;

      String savePath = new File(uploadDir, savedFilename).getAbsolutePath();

      // 저장
      file.transferTo(new File(savePath));

      playlist.setThumbnailUrl("/thumbnail/" + savedFilename);

    } catch(Exception e) {
          e.printStackTrace();
      }
  }
}
