package com.cosmus.resonos.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cosmus.resonos.domain.Users;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;



@Slf4j
@Controller
@RequestMapping("/user")
public class UserController {

  /**
   * 로그인 페이지 요청
   * @param param
   * @return
   */
  @PostMapping("/login")
  public String login(@RequestParam String param) {
      return new String();
  }

  /**
   * 마이페이지 요청
   * @param model
   * @return
   */
  @GetMapping("/mypage")
  // security 활성화 하면
  // public String mypage(@AuthenticationPrincipal UserDetails userDetails, Model model) {
  public String mypage(Model model) {
    Users user = Users.builder().email("resonos12@gmail.com").username("김조은").build();

    model.addAttribute("user", user);
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
   * 유저 팔로우 페이지 요청
   * @param model
   * @param request
   * @return
   */
  @GetMapping("/follow-user")
  public String followUsers(Model model, HttpServletRequest request) {
    String uri = request.getRequestURI();
    String[] parts = uri.split("/");
    String lastPath = parts[parts.length - 1];
    log.info("lastPath : {}", lastPath);

    model.addAttribute("lastPath", lastPath);

    return "user/follow_user";
  }

  @GetMapping("/playlist")
  public String playlist(Model model, HttpServletRequest request) {
    String uri = request.getRequestURI();
    String[] parts = uri.split("/");
    String lastPath = parts[parts.length - 1];
    log.info("lastPath : {}", lastPath);

    model.addAttribute("lastPath", lastPath);
    return "user/playlist";
  }


  /**
   * 아티스트 팔로우 페이지 요청
   * @param model
   * @param request
   * @return
   */
  @GetMapping("/follow-artist")
  public String followArtists(Model model, HttpServletRequest request) {
    String uri = request.getRequestURI();
    String[] parts = uri.split("/");
    String lastPath = parts[parts.length - 1];
    log.info("lastPath : {}", lastPath);

    model.addAttribute("lastPath", lastPath);
    return "user/follow_artist";
  }

  /**
   * 좋아요 한 앨범/트랙 페이지 요청
   * @param model
   * @param request
   * @return
   */
  @GetMapping("/liked-music")
  public String likedMusic(Model model, HttpServletRequest request) {
    String uri = request.getRequestURI();
    String[] parts = uri.split("/");
    String lastPath = parts[parts.length - 1];
    log.info("lastPath : {}", lastPath);

    model.addAttribute("lastPath", lastPath);
    return "user/liked_music";
  }



}
