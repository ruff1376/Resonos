package com.cosmus.resonos.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cosmus.resonos.service.AlbumMoodVoteService;
import com.cosmus.resonos.service.TrackMoodVoteService;
// import com.cosmus.resonos.service.ArtistVoteService;

@Controller
@RequestMapping("/admin/vote")
public class AdminVoteController {

    @Autowired
    private TrackMoodVoteService trackMoodVoteService;

    @Autowired
    private AlbumMoodVoteService albumMoodVoteService;

    // @Autowired
    // private ArtistVoteService artistVoteService;

    @GetMapping("")
    public String voteStats(
        @RequestParam(value = "tab", defaultValue = "track") String tab,
        Model model
    ) {
        List<Map<String, Object>> stats = null;
        if ("album".equals(tab)) {
            stats = albumMoodVoteService.getAlbumMoodStats();
        } else if ("artist".equals(tab)) {
            // stats = artistVoteService.getArtistVoteStats();
            stats = List.of(); // 임시: 아티스트 투표 구현 전까지 빈 리스트
        } else { // track (기본)
            stats = trackMoodVoteService.getTrackMoodStats();
        }
        model.addAttribute("stats", stats);
        model.addAttribute("tab", tab);
        return "admin/vote"; // vote.html (또는 vote_stats.html)
    }
}
