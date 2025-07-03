package com.cosmus.resonos.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.validation.EmailCheck;
import com.cosmus.resonos.validation.NicknameCheck;
import com.cosmus.resonos.validation.PasswordCheck;
import com.cosmus.resonos.validation.UsernameCheck;

import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;




@Slf4j
@Controller
@RequestMapping("")
public class HomeController {

  /**
   * 로그인 페이지 요청
   * @return
   */
  @GetMapping("/login")
  public String login() {
    return "user/login";
  }

  /**
   * 회원가입 페이지 요청
   * @return
   */
  @GetMapping("/join")
  public String join(@ModelAttribute Users user) {

    return "user/join";
  }

  /**
   * 회원가입 요청
   * @param user
   * @return
   */
  @PostMapping("/join")
  public ResponseEntity<?> joinPost(@Valid @ModelAttribute Users user, BindingResult br) {

    if (br.hasErrors()) {
      log.info("유효성 검사 실패");
      br.getFieldErrors().forEach(fe ->
        log.info("Field: {}, Message: {}", fe.getField(), fe.getDefaultMessage())
      );
      return ResponseEntity.badRequest().body(br.getFieldErrors());
    }

    log.info("user : {}", user);
    return new ResponseEntity<>("SUCCESS", HttpStatus.CREATED);
  }

  /**
   * 아이디 유효성 검사
   * @param user
   * @param br
   * @return
   */
  @PostMapping(value = "/check-id", consumes = "application/json")
  public ResponseEntity<?> checkId(@Validated(UsernameCheck.class) @RequestBody Users user, BindingResult br) {

    // TODO: DB 조회 해서 있는 아이디면 중복이라고 응답

    if (br.hasErrors()) {
      log.info("유효성 검사 실패");
      br.getFieldErrors().forEach(fe ->
        log.info("Field: {}, Message: {}", fe.getField(), fe.getDefaultMessage())
    );
      return ResponseEntity.badRequest().body(br.getFieldErrors());
    }

    return new ResponseEntity<>("사용가능한 아이디입니다.", HttpStatus.OK);
  }

  @PostMapping(value = "/check-nickname", consumes = "application/json")
  public ResponseEntity<?> checkNickname(@Validated(NicknameCheck.class) @RequestBody Users user, BindingResult br) {

    // TODO: DB 조회 해서 있는 닉네임이면 중복이라고 응답

    if (br.hasErrors()) {
      log.info("유효성 검사 실패");
      br.getFieldErrors().forEach(fe ->
        log.info("Field: {}, Message: {}", fe.getField(), fe.getDefaultMessage())
    );
      return ResponseEntity.badRequest().body(br.getFieldErrors());
    }

    return new ResponseEntity<>("사용가능한 닉네임입니다.", HttpStatus.OK);
  }

  @PostMapping(value = "/check-email", consumes = "application/json")
  public ResponseEntity<?> checkEmail(@Validated(EmailCheck.class) @RequestBody Users user, BindingResult br) {

    if (br.hasErrors()) {
      log.info("유효성 검사 실패");
      br.getFieldErrors().forEach(fe ->
        log.info("Field: {}, Message: {}", fe.getField(), fe.getDefaultMessage())
    );
      return ResponseEntity.badRequest().body(br.getFieldErrors());
    }

    return new ResponseEntity<>("유효한 이메일입니다.", HttpStatus.OK);
  }

  @PostMapping(value = "/check-password", consumes = "application/json")
  public ResponseEntity<?> checkPassword(@Validated(PasswordCheck.class) @RequestBody Users user, BindingResult br) {


    if (br.hasErrors()) {
      log.info("유효성 검사 실패");
      br.getFieldErrors().forEach(fe ->
        log.info("Field: {}, Message: {}", fe.getField(), fe.getDefaultMessage())
    );
      return ResponseEntity.badRequest().body(br.getFieldErrors());
    }

    return new ResponseEntity<>("유효한 비밀번호입니다.", HttpStatus.OK);
  }

}
