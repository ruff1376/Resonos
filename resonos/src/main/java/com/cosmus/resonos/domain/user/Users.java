package com.cosmus.resonos.domain.user;

import java.util.Date;
import java.util.List;

import org.springframework.validation.annotation.Validated;

import com.cosmus.resonos.validation.EmailCheck;
import com.cosmus.resonos.validation.NicknameCheck;
import com.cosmus.resonos.validation.PasswordCheck;
import com.cosmus.resonos.validation.UsernameCheck;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Validated
public class Users {
    private Long id;
    @NotBlank(
        message = "아이디를 입력해주세요.",
        groups = UsernameCheck.class
    )
    @Pattern(
        regexp = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$",
        message = "숫자, 영문자 포함 6자 이상이어야 합니다.",
        groups = UsernameCheck.class
    )
    private String username;

    @NotBlank(
        message = "이메일을 입력해주세요.",
        groups = EmailCheck.class
    )
    @Email(
        message = "유효한 형식의 이메일을 입력해주세요.",
        groups = EmailCheck.class
    )
    private String email;

    @NotBlank(message = "비밀번호를 입력해주세요.",
    groups = PasswordCheck.class
    )
    @Pattern(
        regexp = "^(?=.*[A-Za-z])(?=.*[!@#$%^&*()_+=\\[\\]{};':\"\\\\|,.<>/?\\-]).{8,}$",
        message = "특수문자, 영문자를 포함한 8글자 이상이어야 합니다.",
        groups = PasswordCheck.class
    )
    private String password;

    @NotBlank(
        message = "닉네임을 입력해주세요.",
        groups = NicknameCheck.class
    )
    @Pattern(
        regexp = "^(?!.*관리자)(?!.*매니저)(?=.{2,10}$)(?=.*[a-zA-Z가-힣])[a-zA-Z가-힣0-9]+$",
        message = "숫자만을 제외한 조합, 특수문자 제외 2 ~ 10글자 사이여야 합니다.",
        groups = NicknameCheck.class
    )
    private String nickname;
    private String profileImage;
    private String bio;
    private boolean isPro;
    private boolean enabled;
    private String provider;
    private String providerId;
    private Date createdAt;
    private int followerCount;
    private Long currentBadge;

    // 회원 정보 수정 시 사용
    private Boolean ban; // 회원 제재 여부(0: 정상, 1: 제재)
    private List<UserActivityLog> logs; // 활동 로그

    private List<UserAuth> authList;


    // 인증 번호
    private String certiNo;

}
