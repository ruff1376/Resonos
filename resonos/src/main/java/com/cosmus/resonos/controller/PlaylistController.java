package com.cosmus.resonos.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.Playlist;
import com.cosmus.resonos.domain.PlaylistDTO;
import com.cosmus.resonos.domain.PlaylistDetail;
import com.cosmus.resonos.domain.PublicUserDto;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.service.PlaylistService;
import com.cosmus.resonos.service.UserService;
import com.cosmus.resonos.util.UploadImage;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequestMapping("/playlists")
@Controller
@EnableMethodSecurity
public class PlaylistController {

    @Autowired
    private PlaylistService playlistService;
    @Autowired
    private UserService userService;

    /**
     * 플레이리스트 생성 페이지 요청
     * @param model
     * @return
     */
    @GetMapping("/create")
    public String playlistCreate(Model model) {
        model.addAttribute("playlist", Playlist.builder().isPublic(true).build());
        model.addAttribute("lastPath", "playlist");

        return "user/create_playlist";
    }

    /**
     * 플레이리스트 생성 요청
     * @param playlist
     * @return
     * @throws Exception
     */
    @PostMapping("")
    public String createPlaylist(
        @ModelAttribute Playlist playlist,
        @AuthenticationPrincipal CustomUser loginUser,
        @RequestParam("thumbnail") MultipartFile file
    ) throws Exception {

        playlist.setUserId(loginUser.getUser().getId());
        // 썸네일 설정 안했으면 기본 로고로
        if(playlist.getThumbnailUrl() == null)
            playlist.setThumbnailUrl("/img/resonosLogo.png");
        // 이미지 파일 저장
        if (!file.isEmpty()) {
            UploadImage.uploadThumbnailImage(file, playlist);
        }

        boolean result = playlistService.insert(playlist);
        if(result) {
            return "redirect:/playlists";
        }

        return "redirect:/playlists/create?fail=true";
    }

    /**
     * 플레이리스트 상세 페이지 요청
     * @param model
     * @param id
     * @return
     * @throws Exception
     */
    @GetMapping("/{id}")
    public String playlistDetail(
        Model model,
        @PathVariable("id") Long id,
        @RequestParam(value = "success", required = false) String success,
        @AuthenticationPrincipal CustomUser loginUser
    ) throws Exception {
        // 플레이리스트 + 트랙 정보
        PlaylistDTO playlist = playlistService.trackOfPlaylist(id);
        // 플레이리스트 소유자
        Long ownerId =  playlist.getUserId();;
        // 자기 자신인지
        boolean isOwner = loginUser != null && loginUser.getId().equals(ownerId);
        // 비공개 + 주인X 조회 불가능
        if(!playlist.getIsPublic() && !isOwner) return "redirect:/playlists";
        // 플레이리스트 주인 정보
        PublicUserDto owner = userService.publicSelectById(ownerId);

        model.addAttribute("owner", owner);
        model.addAttribute("playlist", playlist);
        model.addAttribute("isOwner", isOwner);
        model.addAttribute("success", success);
        model.addAttribute("lastPath", "playlist");
        return "user/playlist_detail";
    }

    /**
     * 트랙 순서 바꾸기 요청
     * @param playlistId
     * @param orderList
     * @return
     * @throws Exception
     */
    @PutMapping("/{playlistId}/tracks/order")
    public ResponseEntity<?> changeOrderNo(@PathVariable("playlistId") Long playlistId, @RequestBody List<Map<String, Object>> orderList) throws Exception {
        boolean result = playlistService.updateTrackOrder(playlistId, orderList);
        if(result) return new ResponseEntity<>("정렬 완료.", HttpStatus.OK);

        return new ResponseEntity<>("정렬 실패.", HttpStatus.BAD_REQUEST);
    }

    /**
     * 플레이리스트 트랙 추가
     * @param data
     * @param playlistId
     * @return
     */
    @PreAuthorize("isAuthenticated()")
    @PostMapping(value = "/{playlistId}/tracks", consumes = "application/json")
    public ResponseEntity<?> insertAjaxTracks(
        @RequestBody Map<String, List<String>> data,
        @PathVariable("playlistId") Long playlistId,
        @AuthenticationPrincipal CustomUser loginUser
    ) {
        try {
            // 권한 체크
            Playlist playlist = playlistService.select(playlistId);
            if(!playlist.getUserId().equals(loginUser.getUser().getId()))
                return new ResponseEntity<>("권한이 없습니다.", HttpStatus.BAD_REQUEST);

            List<String> trackIdList = data.get("list");
            int maxOrderNo = playlistService.getMaxOrderNo(playlistId);

            if(trackIdList != null) {
                List<PlaylistDetail> trackList = new ArrayList<>();
                for (int i = 0; i < trackIdList.size(); i++) {
                    PlaylistDetail pd = new PlaylistDetail();
                    pd.setPlaylistId(playlistId);
                    pd.setTrackId(trackIdList.get(i));
                    pd.setOrderNo(maxOrderNo + i + 1);
                    trackList.add(pd);
                }
                boolean result = playlistService.insertTracks(trackList);
                if(result) {
                    PlaylistDTO playlistDto = playlistService.trackOfPlaylist(playlistId);

                    return new ResponseEntity<>(playlistDto, HttpStatus.OK);
                }
            }
            return new ResponseEntity<>("리스트 요청 실패.", HttpStatus.BAD_REQUEST);
        }
        catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("이미 플레이리스트에 있는 트랙입니다.", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * 플레이리스트 트랙 삭제
     * @param playlistId
     * @param orderNo
     * @return
     * @throws Exception
     */
    @PreAuthorize("isAuthenticated()")
    @DeleteMapping("/{playlistId}/tracks/{orderNo}")
    public ResponseEntity<?> deleteByOrderNo(@PathVariable("playlistId") Long playlistId, @PathVariable("orderNo") int orderNo) throws Exception {
        boolean result = playlistService.deleteTracks(playlistId, orderNo);
        if(result) {
            PlaylistDTO playlistDto = playlistService.trackOfPlaylist(playlistId);
            if(playlistDto != null) {
                List<Track> trackList = playlistDto.getTrackList();
                if(trackList != null && !trackList.isEmpty()) {
                    for(int i = 1; i <= trackList.size(); i++)
                        trackList.get(i-1).setOrderNo(i);
                    playlistService.updateTrackOrderNo(playlistId, trackList);
                }
            }

            return new ResponseEntity<>(playlistDto, HttpStatus.OK);
        }

        return new ResponseEntity<>("트랙 삭제 실패.", HttpStatus.BAD_REQUEST);
    }

    /**
     * 플레이리스트 수정 요청
     * @param id
     * @param playlist
     * @param loginUser
     * @return
     * @throws Exception
     */
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/{id}")
    public String updatePlaylist(
        @PathVariable("id") Long id,
        @ModelAttribute Playlist playlist,
        @AuthenticationPrincipal CustomUser loginUser,
        @RequestParam("thumbnail") MultipartFile file
    ) throws Exception {

        // 이미지 파일 저장
        if (!file.isEmpty()) {
            UploadImage.uploadThumbnailImage(file, playlist);
        }

        Playlist currentPlaylist = playlistService.select(id);
        if(!currentPlaylist.getUserId().equals(loginUser.getUser().getId()))
            return "redirect:/playlists/" + id + "?owner=false";
        else {
            playlist.setId(id);
            playlist.setUserId(loginUser.getUser().getId());
            boolean success = playlistService.update(playlist);
            if (success)  {
                log.info("updatePlaylist : 플레이리스트 업데이트 성공");
                return "redirect:/playlists/" + id + "?success=true";
            }
        }
        return "redirect:/playlists/" + id + "?fail=true";
    }

    /**
     * 플레이리스트 삭제 요청
     * @param id
     * @return
     * @throws Exception
     */
    @PreAuthorize("isAuthenticated()")
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletePlaylist(
        @PathVariable("id") Long id,
        @AuthenticationPrincipal CustomUser loginUser
    ) throws Exception {
        log.info("넘어온 아이디 : {}", id);

        Playlist playlist = playlistService.select(id);
        if (playlist == null)
            return new ResponseEntity<>("해당 플레이리스트가 존재하지 않습니다.", HttpStatus.NOT_FOUND);

        Long onwnerId = playlist.getUserId();

        if(!loginUser.getUser().getId().equals(onwnerId))
            return new ResponseEntity<>("권한이 없습니다.", HttpStatus.BAD_REQUEST);

        boolean result = playlistService.delete(id);
        if(result) {
            List<Playlist> playlists = playlistService.usersPlaylist(loginUser.getUser().getId());
            return new ResponseEntity<>(playlists, HttpStatus.OK);
        }

        return new ResponseEntity<>("삭제 실패하였습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
