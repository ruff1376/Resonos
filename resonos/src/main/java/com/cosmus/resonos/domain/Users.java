package com.cosmus.resonos.domain;

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
        regexp = "^(?=.{2,10}$)([a-zA-Z]+[0-9]+|[0-9]+[a-zA-Z]+|[가-힣]+[0-9]+|[0-9]+[가-힣]+|[a-zA-Z]{2,10}|[가-힣]{2,10})$",
        message = "영문 + 숫자, 한글 + 숫자, 한글, 영문 조합 2글자 이상, 10글자 이하여야 합니다.",
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

    private List<UserAuth> authList;
}
