package com.cosmus.resonos.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.web.bind.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.service.UserService;
import com.cosmus.resonos.validation.EmailCheck;
import com.cosmus.resonos.validation.NicknameCheck;
import com.cosmus.resonos.validation.PasswordCheck;
import com.cosmus.resonos.validation.UsernameCheck;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {

  @GetMapping("/login")
  public String login() {
    return "user/login";
  }


  @Autowired private UserService userService;

    @GetMapping("")
    // public String home(Principal principal, Model model) throws Exception {
    // public String home(Authentication authentication, Model model) throws Exception {
    public String home(@AuthenticationPrincipal CustomUser authUser, Model model) throws Exception {
        log.info(":::::::::: 메인 화면 ::::::::::");

        // if( principal != null ) {
        //     String username = principal.getName();              // 인증된 사용자 아이디
        //     log.info("username : {}", username);
        //     Users user = userService.select(username);          // 사용자 정보 조회
        //     log.info("user : {}", user);
        //     model.addAttribute("user", user);     // 사용자 정보 모델에 등록
        // }

        // if( authentication != null ) {
        //     User user = (User) authentication.getPrincipal();
        //     String username = user.getUsername();              // 인증된 사용자 아이디
        //     String password = user.getPassword();              // 인증된 사용자 비밀번호
        //     Collection<GrantedAuthority> authList = user.getAuthorities();  // 사용자 권한
        //     log.info("username : {}", username);
        //     log.info("password : {}", password);
        //     log.info("authList : {}", authList);
        //     Users joinedUser = userService.select(username);          // 사용자 정보 조회
        //     log.info("joinedUser : {}", joinedUser);
        //     model.addAttribute("joinedUser", joinedUser);     // 사용자 정보 모델에 등록
        // }

        // if( authUser != null ) {
        //     log.info("authUser : {}", authUser);
        //     User user = authUser.getUser();
        //     model.addAttribute("user", user);
        // }

        return "index";
    }



    /**
     * 회원 가입 화면
     * @return
     */
    @GetMapping("/join")
    public String join() {
        return "join";
    }

    /**
     * 회원 가입 처리
     * @param user
     * @return
     * @throws Exception
     */
    @PostMapping("/join")
    public String joinPost(Users user, HttpServletRequest request) throws Exception {
        // 암호화 전 비밀 번호
        String plainPassword = user.getPassword();
        // 회원 가입 요청
        int result = userService.join(user);
        // 회원 가입 성공 시, 바로 로그인 ⚡🔐
        boolean loginResult = false;
        if( result > 0 ) {
            // 암호화 전 비밀번호로 다시 세팅
            user.setPassword(plainPassword);
            loginResult = userService.login(user, request);  // ⚡🔐 바로 로그인
        }
        if(loginResult)
            // 메인 화면으로 이동
            return "redirect:/";
        if(result > 0)
            // 로그인 화면으로 이동
            return "redirect:/login";
        return "redirect:/join?error=true";
    }


    /**
     * 로그인 화면
     * @return
     */
    @GetMapping("/login")
    public String login(
        @CookieValue(value = "remember-id", required = false) Cookie cookie,
        Model model
    ) {
        log.info(":::::::::: 로그인 페이지 ::::::::::");
        String username = "";
        boolean rememberId = false;
        if( cookie != null ) {
            log.info("CookieName : " + cookie.getName());
            log.info("CookieValue : " + cookie.getValue());
            username = cookie.getValue();
            rememberId = true;
        }
        model.addAttribute("username", username);
        model.addAttribute("rememberId", rememberId);
        return "login";
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