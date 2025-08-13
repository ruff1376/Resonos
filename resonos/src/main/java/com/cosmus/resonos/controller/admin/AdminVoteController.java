package com.cosmus.resonos.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.cosmus.resonos.service.admin.ArtistVoteStatsService;
import com.cosmus.resonos.service.review.ArtistMoodVoteService;
import com.cosmus.resonos.service.review.TrackMoodVoteService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@CrossOrigin("*")
@RestController
@RequestMapping("/admin/vote")
public class AdminVoteController {

    @Autowired
    private TrackMoodVoteService trackMoodVoteService;

    @Autowired
    private ArtistMoodVoteService artistMoodVoteService;

    @Autowired
    private ArtistVoteStatsService artistVoteStatsService;

    /** 투표 통계 (트랙/앨범/아티스트) */
    @GetMapping("")
    public ResponseEntity<?> voteStats(
        @RequestParam(name = "tab", defaultValue = "track") String tab
    ) {
        Map<String, Object> res = new HashMap<>();
        try {
            List<Map<String, Object>> stats;

            switch (tab) {
                case "album":
                    stats = artistMoodVoteService.getArtistMoodStats();
                    break;
                case "artist":
                    stats = artistVoteStatsService.getArtistMoodVoteStats();
                    break;
                case "track":
                default:
                    stats = trackMoodVoteService.getTrackMoodStats();
                    break;
            }

            res.put("success", true);
            res.put("tab", tab);
            res.put("stats", stats != null ? stats : List.of());

        } catch (Exception e) {
            log.error("투표 통계 조회 오류", e);
            res.put("success", false);
            res.put("message", "투표 통계 조회 중 오류가 발생했습니다.");
            res.put("tab", tab);
            res.put("stats", List.of());
        }

        return ResponseEntity.ok(res);
    }
}
