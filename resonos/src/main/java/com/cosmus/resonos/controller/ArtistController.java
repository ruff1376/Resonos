package com.cosmus.resonos.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.domain.Album.Album;
import com.cosmus.resonos.domain.Artist.Artist;
import com.cosmus.resonos.domain.Artist.ArtistFollow;
import com.cosmus.resonos.domain.Artist.ArtistMoodVote;
import com.cosmus.resonos.domain.Review.RecentReview;
import com.cosmus.resonos.domain.Track.Track;
import com.cosmus.resonos.domain.Vote.MoodStat;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.ArtistFollowService;
import com.cosmus.resonos.service.ArtistMoodVoteService;
import com.cosmus.resonos.service.ArtistService;
import com.cosmus.resonos.service.MoodStatService;
import com.cosmus.resonos.service.RecentReviewService;
import com.cosmus.resonos.service.TagService;
import com.cosmus.resonos.service.TrackService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/artists")
public class ArtistController {


    @Autowired
    private ArtistService artistService;
    @Autowired
    private AlbumService albumService;
    @Autowired
    private TrackService trackService;
    @Autowired
    private ArtistFollowService artistFollowService;
    @Autowired
    private ArtistMoodVoteService artistMoodVoteService;
    @Autowired
    private MoodStatService moodStatService;
    @Autowired
    private TagService tagService;
    @Autowired
    private RecentReviewService recentReviewService;

    // 아티스트 화면
    @GetMapping
    public String artistsInfo(@RequestParam("id") String id, Model model,
                                @AuthenticationPrincipal CustomUser user) throws Exception {
        Users loginUser = null;
        if( user != null ) {
            // 로그인시에 유저정보 가져오기
            loginUser = user.getUser();
            model.addAttribute("loginUser", loginUser);
            // 팔로우 여부 체크
            boolean isArtistFollowed = artistFollowService.isLikedByUser(loginUser.getId(), id);
            model.addAttribute("isArtistFollowed", isArtistFollowed);
            Long userVotedMoodId = artistMoodVoteService.getUserVotedMoodId(loginUser.getId(), id);
            model.addAttribute("userVotedMoodId", userVotedMoodId);
        } else {
            model.addAttribute("isArtistFollowed", false);
        }

        Integer followCount = artistFollowService.getArtistFollowCount(id);
        model.addAttribute("followCount", followCount);
        Artist artist = artistService.selectById(id);
        List<Album> albums = albumService.findAlbumsByArtistId(id);
        int albumCount = albumService.countAlbumsByArtist(id);
        int trackCount = trackService.countTracksByArtist(id);
        List<Track> top7List = trackService.selectTop7TracksByArtistAndFetchMv(id);
        Track track = top7List.get(0);

        List<MoodStat> moodStats = moodStatService.getTop6MoodsByArtistId(id);
        boolean isMoodEmpty = (moodStats == null || moodStats.isEmpty());
        List<String> moodLabels = moodStats.stream().map(MoodStat::getMoodName).toList();
        List<Integer> moodValues = moodStats.stream().map(MoodStat::getVoteCount).toList();

        List<RecentReview> reviews = recentReviewService.getRecentReviewsByArtistId(id);
        model.addAttribute("recentReviews", reviews);
        model.addAttribute("artist", artist);
        model.addAttribute("track", track);
        model.addAttribute("albums", albums);
        model.addAttribute("albumCount", albumCount);
        model.addAttribute("TOP7", top7List);
        model.addAttribute("trackCount", trackCount);
        model.addAttribute("isMoodEmpty", isMoodEmpty);
        model.addAttribute("moodLabels", moodLabels);
        model.addAttribute("moodValues", moodValues);
        model.addAttribute("tags", tagService.list());

        if (artist == null) {
            return "redirect:/artists?error=notfound";
        }
        return "review/artist";  // templates/artists/detail.html 뷰 렌더링
    }

    @PostMapping("/toggle-like")
    @ResponseBody
    public ResponseEntity<?> toggleTrackLike(@RequestBody ArtistFollow dto) throws Exception {
        boolean followed = artistFollowService.toggleLike(dto.getUserId(), dto.getArtistId());
        Integer count = artistFollowService.getArtistFollowCount(dto.getArtistId());

        Map<String, Object> result = new HashMap<>();
        result.put("followed", followed);
        result.put("count", count);

        return ResponseEntity.ok(result);
    }


    @PostMapping("/vote-mood")
    @ResponseBody
    public ResponseEntity<?> voteMood(@RequestBody ArtistMoodVote request) throws Exception {
        artistMoodVoteService.saveOrUpdateVote(request.getUserId(), request.getArtistId(), request.getMood());
        if (request.getUserId() == null || request.getArtistId() == null || request.getMood() == null) {
            return ResponseEntity.badRequest().body("필수 데이터 누락");
        }
        Long votedMoodId = artistMoodVoteService.getUserVotedMoodId(request.getUserId(), request.getArtistId());
        List<MoodStat> moodStats = moodStatService.getTop6MoodsByArtistId(request.getArtistId());
        List<String> moodLabels = moodStats.stream().map(MoodStat::getMoodName).toList();
        List<Integer> moodValues = moodStats.stream().map(MoodStat::getVoteCount).toList();
        Map<String, Object> response = new HashMap<>();
        response.put("votedMoodId", votedMoodId);
        response.put("labels", moodLabels);
        response.put("values", moodValues);
        response.put("moods", tagService.list());
        return ResponseEntity.ok(response);
    }

    /**
     * 비동기 팔로우 아티스트 검색
     * @param data
     * @return
     * @throws Exception
     */
    @PostMapping("/search")
    public ResponseEntity<?> searchMyAlbums(
        @RequestBody Map<String, Object> data
    ) throws Exception {
        Long userId = Long.valueOf(data.get("userId").toString());
        String keyword = data.get("keyword").toString();
        int offset = Integer.parseInt(data.get("offset").toString());
        int limit = Integer.parseInt(data.get("limit").toString());

        List<Artist> artistList = artistService.followingArtists(userId, keyword, offset, limit);
        if(artistList != null)
            return new ResponseEntity<>(artistList, HttpStatus.OK);

        return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);

    }

}
