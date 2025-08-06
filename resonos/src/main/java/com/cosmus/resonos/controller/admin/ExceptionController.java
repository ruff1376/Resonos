package com.cosmus.resonos.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class ExceptionController {

    @GetMapping("/error/403")
    public String error403() {
        log.info("접근 권한이 없습니다.");

        return "error/403";
    }


}
