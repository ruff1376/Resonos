package com.cosmus.resonos.controller.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
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
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.review.Track;
import com.cosmus.resonos.domain.user.Playlist;
import com.cosmus.resonos.domain.user.PlaylistDTO;
import com.cosmus.resonos.domain.user.PlaylistDetail;
import com.cosmus.resonos.domain.user.PublicUserDto;
import com.cosmus.resonos.service.review.TrackService;
import com.cosmus.resonos.service.user.PlaylistService;
import com.cosmus.resonos.service.user.UserService;
import com.cosmus.resonos.util.UploadImage;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequestMapping("/playlists")
@RestController
@EnableMethodSecurity
public class PlaylistController {

    @Autowired
    private PlaylistService playlistService;
    @Autowired
    private UserService userService;
    @Autowired
    private TrackService trackService;

    /**
     * 플레이리스트 생성 요청
     * @param playlist
     * @return
     * @throws Exception
     */
    @PostMapping("")
    public ResponseEntity<?> createPlaylist(
        @ModelAttribute Playlist playlist,
        @AuthenticationPrincipal CustomUser loginUser,
        @RequestParam(value = "thumbnail", required = false) MultipartFile file
    ) throws Exception {

        log.info("playlist : {}", playlist);

        playlist.setUserId(loginUser.getUser().getId());
        // 썸네일 설정 안했으면 기본 로고로
        if(playlist.getThumbnailUrl() == null)
            playlist.setThumbnailUrl("/img/profileImg.png");
        // 이미지 파일 저장
        if (file != null && !file.isEmpty()) {
            UploadImage.uploadThumbnailImage(file, playlist);
        }

        boolean result = playlistService.insert(playlist);
        if(result) {
            return new ResponseEntity<>(HttpStatus.CREATED);
        }

        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    /**
     * 플레이리스트 상세 페이지 요청
     * @param model
     * @param id
     * @return
     * @throws Exception
     */
    @GetMapping("/{id}")
    public ResponseEntity<?> playlistDetail(
        Model model,
        @PathVariable("id") Long id,
        @AuthenticationPrincipal CustomUser loginUser
    ) throws Exception {
        // 플레이리스트 소유자
        Long ownerId =  playlistService.select(id).getUserId();
        // 플레이리스트 + 트랙 정보
        PlaylistDTO playlist = playlistService.trackOfPlaylist(id, ownerId);
        // 자기 자신인지
        boolean isOwner = loginUser != null && loginUser.getId().equals(ownerId);
        // 비공개 + 주인X 조회 불가능
        if(!playlist.getIsPublic() && !isOwner) return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
        // 플레이리스트 주인 정보
        PublicUserDto owner = userService.publicSelectById(ownerId);
        // 좋아요 눌렀는지
        boolean alreadyLiked = loginUser != null ? playlistService.alreadyLikedPlaylist(loginUser.getId(), id) : false;

        Map<String, Object> response = new HashMap<>();

        response.put("userId", ownerId);
        response.put("alreadyLiked", alreadyLiked);
        response.put("owner", owner);
        response.put("playlist", playlist);
        response.put("isOwner", isOwner);
        response.put("lastPath", "playlist");

        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    /**
     * 플레이리스트에 추가할 트랙 리스트 요청
     *
     * @param entity
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/tracks", consumes = "application/json")
    public ResponseEntity<?> getAjaxTracks(@RequestBody Map<String, String> data) throws Exception {
        log.info("트랙 요청 들어옴.");
        int offset = Integer.parseInt(data.get("offset").toString());
        int limit = Integer.parseInt(data.get("limit").toString());
        List<Track> trackList = trackService.addTrackList(data.get("keyword"), offset, limit);
        if (trackList != null)
            return new ResponseEntity<>(trackList, HttpStatus.OK);
        log.info("trackList : {}", trackList);
        return new ResponseEntity<>("리스트 요청 실패.", HttpStatus.BAD_REQUEST);
    }

    /**
     * 트랙 순서 바꾸기 요청
     * @param playlistId
     * @param orderList
     * @return
     * @throws Exception
     */
    @PutMapping("/{playlistId}/tracks/order")
    public ResponseEntity<?> changeOrderNo(
        @PathVariable("playlistId") Long playlistId,
        @RequestBody List<Map<String, Object>> orderList,
        @AuthenticationPrincipal CustomUser loginUser
    ) throws Exception {
        Long ownerId = playlistService.select(playlistId).getUserId();
        log.info("ownerId : {}", ownerId);
        log.info("customUser : {}", loginUser.getId());
        if(loginUser == null || !loginUser.getId().equals(ownerId))
            return new ResponseEntity<>("권한이 없습니다.", HttpStatus.FORBIDDEN);
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
                    PlaylistDTO playlistDto = playlistService.trackOfPlaylist(playlistId, loginUser.getId());

                    return new ResponseEntity<>(playlistDto, HttpStatus.OK);
                }
            }
            return new ResponseEntity<>("리스트 요청 실패.", HttpStatus.BAD_REQUEST);
        }
        catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("이미 플레이리스트에 존재합니다.", HttpStatus.INTERNAL_SERVER_ERROR);
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
    public ResponseEntity<?> deleteByOrderNo(@PathVariable("playlistId") Long playlistId, @PathVariable("orderNo") int orderNo, @AuthenticationPrincipal CustomUser loginUser) throws Exception {
        boolean result = playlistService.deleteTracks(playlistId, orderNo);
        if(result) {
            PlaylistDTO playlistDto = playlistService.trackOfPlaylist(playlistId, loginUser.getId());
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
    @PutMapping("/{id}")
    public ResponseEntity<?> updatePlaylist(
        @PathVariable("id") Long id,
        @ModelAttribute Playlist playlist,
        @AuthenticationPrincipal CustomUser loginUser,
        @RequestParam(value = "thumbnail", required = false) MultipartFile file
    ) throws Exception {

        // 이미지 파일 저장
        if (file != null && !file.isEmpty()) {
            UploadImage.uploadThumbnailImage(file, playlist);
        }

        Playlist currentPlaylist = playlistService.select(id);
        if(!currentPlaylist.getUserId().equals(loginUser.getUser().getId()))
            return new ResponseEntity<>("success", HttpStatus.UNAUTHORIZED);
        else {
            playlist.setId(id);
            playlist.setUserId(loginUser.getUser().getId());
            boolean success = playlistService.update(playlist);
            if (success)  {
                log.info("updatePlaylist : 플레이리스트 업데이트 성공");
                return new ResponseEntity<>(HttpStatus.OK);
            }
        }
        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
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

    /**
     * 플레이리스트 좋아요 요청
     * @param playlistId
     * @param orderList
     * @return
     * @throws Exception
     */
    @PostMapping("/{playlistId}/like")
    public ResponseEntity<?> likePlaylist(
        @PathVariable("playlistId") Long playlistId,
        @AuthenticationPrincipal CustomUser loginUser
    ) throws Exception {
        if(loginUser == null) return new ResponseEntity<>("로그인이 필요한 서비스입니다.", HttpStatus.UNAUTHORIZED);
        boolean result = playlistService.likePlaylist(loginUser.getId(), playlistId);
        if(result)
            return new ResponseEntity<>("이 플레이리스트를 좋아요 합니다.", HttpStatus.OK);

        return new ResponseEntity<>("에러.", HttpStatus.INTERNAL_SERVER_ERROR);
    }

    /**
     * 플레이리스트 좋아요 취소 요청
     * @param playlistId
     * @param orderList
     * @return
     * @throws Exception
     */
    @DeleteMapping("/{playlistId}/like")
    public ResponseEntity<?> likePlaylistCancle(
        @PathVariable("playlistId") Long playlistId,
        @AuthenticationPrincipal CustomUser loginUser
    ) throws Exception {
        boolean result = playlistService.cancleLikePlaylist(loginUser.getId(), playlistId);
        if(result)
            return new ResponseEntity<>("좋아요를 취소하였습니다.", HttpStatus.OK);

        return new ResponseEntity<>("에러.", HttpStatus.BAD_REQUEST);
    }

    /**
     * 비동기 좋아요 한 플레이리스트 검색
     * @param data
     * @return
     * @throws Exception
     */
    @PostMapping("/search")
    public ResponseEntity<?> searchMyLikedPlaylist(
        @RequestBody Map<String, Object> data
    ) throws Exception {
        Long userId = Long.valueOf(data.get("userId").toString());
        String keyword = data.get("keyword").toString();
        int offset = Integer.parseInt(data.get("offset").toString());
        int limit = Integer.parseInt(data.get("limit").toString());

        List<Playlist> likedPlaylists = playlistService.likedPlaylist(userId, keyword, offset, limit);
        if(likedPlaylists != null)
            return new ResponseEntity<>(likedPlaylists, HttpStatus.OK);

        return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
