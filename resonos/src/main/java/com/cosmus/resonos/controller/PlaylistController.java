package com.cosmus.resonos.controller;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.service.PlaylistDetailService;
import com.cosmus.resonos.service.PlaylistService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequestMapping("/playlists")
@Controller
public class PlaylistController {

    @Autowired
    private PlaylistService playlistService;

    @Autowired
    private PlaylistDetailService playlistDetailService;



    /**
     * 플레이리스트 페이지 요청
     * @param model
     * @return
     * @throws Exception
     */
    @GetMapping("")
    public String playlist(@AuthenticationPrincipal CustomUser loginUser, Model model) throws Exception {

        List<Playlist> myPlaylists = playlistService.usersPlaylist(loginUser.getUser().getId());
        List<Playlist> likedPlaylists = playlistService.likedPlaylist(loginUser.getUser().getId());

        model.addAttribute("loginUser", loginUser.getUser());
        model.addAttribute("myPlaylists", myPlaylists);
        model.addAttribute("likedPlaylists", likedPlaylists);
        model.addAttribute("lastPath", "playlist");
        return "user/playlist";
    }

    /**
     * 플레이리스트 추가 페이지 요청
     * @param model
     * @return
     */
    @GetMapping("/create")
    public String playlistCreate(Model model) {

        model.addAttribute("playlistObj", Playlist.builder().isPublic(true).build());
        model.addAttribute("lastPath", "playlist");

        return "user/create_playlist";
    }

    /**
     * 플레이리스트 상세 페이지 요청
     * @param model
     * @param id
     * @return
     * @throws Exception
     */
    @GetMapping("/{id}")
    public String playlistDetail(Model model, @PathVariable("id") long id, @RequestParam(value = "success", required = false) String success) throws Exception {
        PlaylistDTO playlist = playlistService.trackOfPlaylist(id);

        if(playlist == null) {
            model.addAttribute("playlist", playlistService.select(id));
        } else {
            model.addAttribute("playlist", playlist);
        }
        model.addAttribute("success", success);
        model.addAttribute("lastPath", "playlist");
        model.addAttribute("playlistObj", new Playlist());
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
     * 플레이리스트 트랙 삭제
     * @param playlistId
     * @param orderNo
     * @return
     * @throws Exception
     */
    @DeleteMapping("/{playlistId}/tracks/{orderNo}")
    public ResponseEntity<?> deleteByOrderNo(@PathVariable("playlistId") Long playlistId, @PathVariable("orderNo") int orderNo) throws Exception {
        boolean result = playlistService.deleteTracks(playlistId, orderNo);
        if(result) {
            PlaylistDTO playlistDto = playlistService.trackOfPlaylist(playlistId);
            if(playlistDto != null) {
                List<Track> trackList = playlistDto.getTrackList();
                for(int i = 1; i <= trackList.size(); i++) {
                    trackList.get(i-1).setOrderNo(i);
                }
                playlistDetailService.updateTrackOrderNo(playlistId, trackList);
            }

            return new ResponseEntity<>(playlistDto, HttpStatus.OK);
        }

        return new ResponseEntity<>("트랙 삭제 실패.", HttpStatus.BAD_REQUEST);
    }

    @PostMapping
    public ResponseEntity<String> createPlaylist(@RequestBody Playlist playlist) {
        try {
            boolean success = playlistService.insert(playlist);
            if (success) {
                return ResponseEntity.ok("Playlist created");
            }
            return ResponseEntity.status(500).body("Failed to create playlist");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to create playlist: " + e.getMessage());
        }
    }

    /**
     * 플레이리스트 수정
     * @param id
     * @param playlist
     * @param loginUser
     * @return
     * @throws Exception
     */
    @PostMapping("/{id}")
    public String updatePlaylist(
        @PathVariable("id") Long id,
        @ModelAttribute Playlist playlist,
        @AuthenticationPrincipal CustomUser loginUser,
        @RequestParam("thumbnail") MultipartFile file
    ) throws Exception {

        // 이미지 파일 저장
        if (!file.isEmpty()) {
            try {
            String uploadDir = System.getProperty("user.dir") + "/resonos/uploads/thumbnail";

            log.info("업로드 경로 : {}", uploadDir);

            File folder = new File(uploadDir);
            if (!folder.exists()) {
                folder.mkdirs(); // 폴더 없으면 생성
            }

            // 파일 이름 중복 방지용
            String originalFilename = file.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String savedFilename = UUID.randomUUID() + extension;

            // static/thumbnail 경로 (resources는 컴파일 시 target/classes로 복사됨)
            String savePath = new File(uploadDir, savedFilename).getAbsolutePath();

            // 저장
            file.transferTo(new File(savePath));

            // DB에 상대경로 저장하는 경우
            playlist.setThumbnailUrl("/thumbnail/" + savedFilename);

            log.info("이미지 저장됨");
            } catch(Exception e) {
                e.printStackTrace();
            }
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
        return "redirect:/playlists/" + id + "?success=false";
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deletePlaylist(@PathVariable Long id) {
        try {
            boolean success = playlistService.delete(id);
            if (success) {
                return ResponseEntity.ok("Playlist deleted");
            }
            return ResponseEntity.status(500).body("Failed to delete playlist");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to delete playlist: " + e.getMessage());
        }
    }
}
