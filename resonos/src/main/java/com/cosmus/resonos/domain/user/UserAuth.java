package com.cosmus.resonos.domain.user;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonValue;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class UserAuth {
    private Long no;
    private String username;
    private String auth;

    public UserAuth(String username, String auth) {
        this.username = username;
        this.auth = auth;
    }

    // 추가: 문자열(auth)로 생성 가능한 생성자 혹은 factory method - react에서 어드민이 권한을 수정할 때 사용
    @JsonCreator
    public UserAuth(String auth) {
        this.auth = auth;
    }

    @JsonValue
    public String getAuth() {
        return auth;
    }
}
