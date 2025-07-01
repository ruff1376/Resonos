package com.cosmus.resonos.controller;

import org.springframework.stereotype.Controller;

import groovy.util.logging.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;


@Slf4j
@Controller
public class ArtistController {

    @GetMapping("/artist")
    public String artist() {
        return "/review/artist";
    }
    

}
