package com.cosmus.resonos.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import groovy.util.logging.Slf4j;


@Slf4j
@Controller
@RequestMapping("/list")
public class ListController {
    
    @GetMapping("/main")
    public String mainList() {
        return "list/main";
    }
    

}
