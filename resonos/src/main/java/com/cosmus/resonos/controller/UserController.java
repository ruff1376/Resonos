package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.Playlist;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.service.PlaylistService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/users")
public class UserController {

  @Autowired PlaylistService playlistService;

  /**
   * 로그인 페이지 요청
   * @param param
   * @return
   */
  // @PostMapping("/login")
  // public String login(@RequestParam String param) {
  //     return new String();
  // }

  /**
   * 마이페이지 요청
   * @param model
   * @return
   * @throws Exception
   */
  @GetMapping("/mypage")
  public String mypage(Model model ,@AuthenticationPrincipal CustomUser loginUser) throws Exception {

    List<Playlist> playlists = playlistService.usersPlaylist3(loginUser.getUser().getId());

    model.addAttribute("playlists", playlists);
    model.addAttribute("loginUser", loginUser.getUser());
    return "user/mypage";
  }

  /**
   * 회웑 정보 수정 페이지 요청
   * @param model
   * @return
   */
  @GetMapping("/edit")
  public String edit(Model model) {
    Users user = Users.builder().nickname("김조김조은").bio("안녕하세요 음악과 우주를 사랑하는 김조은입니다.").email("resonos12@gmail.com").username("김조은").build();
    model.addAttribute("user", user);

    return "user/edit";
  }

  /**
   * 회원 정보 수정 요청
   * @param user
   * @return
   */
  @PostMapping("/edit")
  public ResponseEntity<?> editPost(@ModelAttribute Users user) {

    if(user != null) {
      log.info("user : {}", user);
      return new ResponseEntity<>("SUCESS", HttpStatus.OK);
    }

    return new ResponseEntity<>("FAIL", HttpStatus.BAD_REQUEST);
  }

  /**
   * 내 활동 페이지 요청
   * @param model
   * @return
   */
  @GetMapping("/activity")
  // TODO: @AuthenticationPrincipal 로 접근 권한
  public String activity(Model model) {

    model.addAttribute("lastPath", "activity");
    return "user/activity";
  }

  @GetMapping("/badge")
  // TODO: @AuthenticationPrincipal 로 접근 권한
  public String badge(Model model) {

    model.addAttribute("lastPath", "badge");
    return "user/badge";
  }

  @GetMapping("/setting-alarm")
  public String getMethodName(Model model) {


    model.addAttribute("lastPath", "setting-alarm");
    return "user/setting-alarm";
  }
}
