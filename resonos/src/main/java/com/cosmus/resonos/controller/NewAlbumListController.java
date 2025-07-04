package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriComponentsBuilder;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.service.AlbumService;

import groovy.util.logging.Slf4j;

@Slf4j
@Controller
@RequestMapping("/list")
public class NewAlbumListController {
    
    @Autowired
    private AlbumService albumService;

    @GetMapping("/new-albums")
    public String newList(Model model, @RequestParam(value = "size", defaultValue = "30") int size, Pagination pagination) throws Exception {
        pagination.setSize(size);
        List<Album> newList = albumService.newList(pagination);
        model.addAttribute("pagination", pagination);
        model.addAttribute("newList", newList);
        String pageUri = UriComponentsBuilder.fromPath("/list/new-albums")
                                            .queryParam("size", pagination.getSize())
                                            .queryParam("count", pagination.getCount())
                                            .build()
                                            .toUriString();
        model.addAttribute("pageUri", pageUri);
        return "list/new_album";
    }
}
