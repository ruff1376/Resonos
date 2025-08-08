package com.cosmus.resonos.controller.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.admin.Notification;
import com.cosmus.resonos.domain.admin.UsersTotalLikes;
import com.cosmus.resonos.domain.badge.Badge;
import com.cosmus.resonos.domain.review.Album;
import com.cosmus.resonos.domain.review.AlbumReview;
import com.cosmus.resonos.domain.review.Artist;
import com.cosmus.resonos.domain.review.Track;
import com.cosmus.resonos.domain.review.TrackReview;
import com.cosmus.resonos.domain.user.Playlist;
import com.cosmus.resonos.domain.user.PublicUserDto;
import com.cosmus.resonos.domain.user.UserNoti;
import com.cosmus.resonos.domain.user.Users;
import com.cosmus.resonos.service.admin.NotificationService;
import com.cosmus.resonos.service.badge.BadgeService;
import com.cosmus.resonos.service.review.AlbumReviewService;
import com.cosmus.resonos.service.review.AlbumService;
import com.cosmus.resonos.service.review.ArtistService;
import com.cosmus.resonos.service.review.TrackReviewService;
import com.cosmus.resonos.service.review.TrackService;
import com.cosmus.resonos.service.user.PlaylistService;
import com.cosmus.resonos.service.user.UserFollowService;
import com.cosmus.resonos.service.user.UserService;
import com.cosmus.resonos.util.FlattenGenreCounts;
import com.cosmus.resonos.util.UploadImage;
import com.cosmus.resonos.validation.EmailCheck;
import com.cosmus.resonos.validation.NicknameCheck;
import com.cosmus.resonos.validation.PasswordCheck;

import io.micrometer.core.ipc.http.HttpSender.Response;
import lombok.extern.slf4j.Slf4j;




@Slf4j
@Controller
@RequestMapping("/users")
public class UserController {

  @Autowired PlaylistService playlistService;

  @Autowired UserService userService;

  @Autowired UserFollowService userFollowService;

  @Autowired AlbumService albumService;

  @Autowired TrackService trackSErvice;

  @Autowired ArtistService artistService;

  @Autowired TrackService trackService;

  @Autowired TrackReviewService trackReviewService;

  @Autowired AlbumReviewService albumReviewServcie;

  @Autowired BadgeService badgeService;

  @Autowired NotificationService notificationService;

  /**
   * 사용자 정보 조회
   * @param customUser
   * @return
   */
  @GetMapping("/info")
  public ResponseEntity<?> userInfo(
      @AuthenticationPrincipal CustomUser customUser
  ) {
      log.info("::::: 사용자 정보 조회 :::::");
      log.info("customUser : " + customUser);

      if( customUser == null ) {
          return new ResponseEntity<>("UNAUTHORIZED", HttpStatus.UNAUTHORIZED);
      }

      Users user = customUser.getUser();
      log.info("user : " + user);

      // 인증된 사용자 정보
      if( user != null ) {
          return new ResponseEntity<>(user, HttpStatus.OK);
      }
      // 인증 되지 않은 경우
      return new ResponseEntity<>("UNAUTHORIZED", HttpStatus.UNAUTHORIZED);
  }

  /**
   * 로그인 페이지 요청
   * @param param
   * @return
   */
  // @PostMapping("/login")
  // public ResponseEntity<?> login(@RequestParam String param) {
  //     return new String();
  // }

  /**
   * 마이페이지 요청
   * @return
   * @throws Exception
   */
  @GetMapping("/mypage")
  public ResponseEntity<?> mypage(
      @AuthenticationPrincipal CustomUser loginUser
    ) throws Exception {
    if(loginUser == null) return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
    log.info("요청한 유저 아이디 : {}", loginUser.getUsername());
    try {

      // 유저 정보
      Users user = userService.select(loginUser.getUsername());
      // 내 플레이 리스트
      List<Playlist> playlists = playlistService.usersPlaylist3(loginUser.getUser().getId());
      // 팔로워 수
      int followerCount = userFollowService.myFollowerCount(user.getId());
      // 팔로우 수
      int followCount = userFollowService.myFollowCount(user.getId());
      // 좋아요 한 앨범
      List<Album> albumList = albumService.likedAlbumsTop3(user.getId());
      // 좋아요 한 트랙
      List<Track> trackList = trackSErvice.likedTracksTop3(user.getId());
      // 팔로우 한 아티스트
      List<Artist> artistList = artistService.followingArtistsTop3(user.getId());
      // 현재 배지
      Badge badge = badgeService.select(user.getCurrentBadge());
      String currentBadge = badge == null ? "" : badge.getName();
      // 최근 획득 배지
      List<Badge> badgeList = badgeService.recentGetBadge(user.getId());
      // 획득 배지 수
      // int badgeCount = badgeService.badgeCount(user.getId());
      // 차트 데이터
      Map<String, Integer> chartData = FlattenGenreCounts.execute(userService.likedGenreData(user.getId()));
      // 리뷰 작성 수
      int countAllReview = albumReviewServcie.countAlbumReview(loginUser.getId()) + trackReviewService.countTrackReview(loginUser.getId());
      // 총 리뷰 수
      UsersTotalLikes utl = userService.usersTotalLikes(loginUser.getId());
      // 응답 객체
      Map<String, Object> response = new HashMap<>();

      response.put("utl", utl);
      response.put("countAllReview", countAllReview);
      response.put("chartData", chartData);
      // response.put("badgeCount", badgeCount);
      response.put("badgeList", badgeList);
      response.put("currentBadge", currentBadge);
      response.put("artistList", artistList);
      response.put("trackList", trackList);
      response.put("albumList", albumList);
      response.put("playlists", playlists);
      response.put("user", user);
      response.put("followerCount", followerCount);
      response.put("followCount", followCount);
      response.put("isOwner", true);

      return new ResponseEntity<>(response, HttpStatus.OK);
    } catch(Exception e) {
      e.printStackTrace();
    }

    return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
  }

  /**
   * 다른 유저의 마이페이지 요청
   * @param id
   * @param loginUser
   * @return
   * @throws Exception
   */
  @GetMapping("/{id}")
  public ResponseEntity<?> userPage(
      @PathVariable("id") Long id,
      @AuthenticationPrincipal CustomUser loginUser
    ) throws Exception {
      log.info("요청 들어옴.");
    try {
      // 관리자 체크
      boolean isAdmin = userService.selectById(id).getAuthList().stream().anyMatch(auth -> "ROLE_ADMIN".equals(auth.getAuth()));
      if(isAdmin) return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
      // 보려는 다른 회원
      PublicUserDto user = userService.publicSelectById(id);
      // 팔로워 수
      int followerCount = userFollowService.myFollowerCount(id);
      // 팔로우 수
      int followCount = userFollowService.myFollowCount(id);
      // 플레이 리스트
      List<Playlist> playlists = playlistService.usersPlaylist3(id);
      // 좋아요 한 앨범
      List<Album> albumList = albumService.likedAlbumsTop3(id);
      // 좋아요 한 트랙
      List<Track> trackList = trackSErvice.likedTracksTop3(id);
      // 팔로우 한 아티스트
      List<Artist> artistList = artistService.followingArtistsTop3(id);
      // 팔로우 했는지
      boolean alreadyFollow = loginUser != null ? userFollowService.checkAlreadyFollow(loginUser.getId(), id) : false ;
      // 현재 배지
      Badge badge = badgeService.select(user.getCurrentBadge());
      String currentBadge = badge == null ? "" : badge.getName();
      // 최근 획득 배지
      List<Badge> badgeList = badgeService.recentGetBadge(id);
      // 획득 배지 수
      int badgeCount = badgeService.badgeCount(id);
      // 차트 데이터
      Map<String, Integer> chartData = FlattenGenreCounts.execute(userService.likedGenreData(user.getId()));
      // 리뷰 작성 수
      int countAllReview = albumReviewServcie.countAlbumReview(id) + trackReviewService.countTrackReview(id);
      // 총 리뷰 수
      UsersTotalLikes utl = userService.usersTotalLikes(id);

      Map<String, Object> response = new HashMap<>();

      // 자기 자신인지
      boolean isOwner = loginUser != null && loginUser.getId().equals(id);
      if(isOwner) {
        Users me = userService.selectById(id);
        response.put("user", me);
      } else {
        // 자기 자신이 아니면 공개 플레이리스트만
        playlists = playlistService.publicUsersPlaylist3(id);
        response.put("user", user);
      }

      response.put("utl", utl);
      response.put("alreadyFollow", alreadyFollow);
      response.put("countAllReview", countAllReview);
      response.put("chartData", chartData);
      response.put("badgeCount", badgeCount);
      response.put("badgeList", badgeList);
      response.put("currentBadge", currentBadge);
      response.put("artistList", artistList);
      response.put("trackList", trackList);
      response.put("albumList", albumList);
      response.put("loginUser", loginUser);
      response.put("user", user);
      response.put("followerCount", followerCount);
      response.put("followCount", followCount);
      response.put("playlists", playlists);
      response.put("isOwner", isOwner);

      if (loginUser != null) {
        response.put("loginUser", loginUser.getUser());
      }

      return new ResponseEntity<>(response, HttpStatus.OK);
    } catch(Exception e) {
      e.printStackTrace();
    }

    return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
  }

  /**
   * 회원 정보 요청
   * @return
   * @throws Exception
   *
   */
  @GetMapping("/edit")
  public ResponseEntity<?> edit(
    @AuthenticationPrincipal CustomUser loginUser
  ) throws Exception {
    if(loginUser == null) return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);

    try {
      Users user = userService.select(loginUser.getUsername());
      List<Badge> badgeList = badgeService.haveBadge(loginUser.getId());
      // 배지 정보
      Badge badge = badgeService.select(user.getCurrentBadge());
      String badgeName = badge == null ? "" : badge.getName();

      Map<String, Object> response = new HashMap<>();

      response.put("badgeName", badgeName);
      response.put("badgeList", badgeList);
      response.put("user", user);

      return new ResponseEntity<>(response, HttpStatus.OK);
    } catch(Exception e) {
      e.printStackTrace();
    }

    return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
  }

  /**
   * 회원 정보 수정 요청
   * @param user
   * @return
   * @throws Exception
   */
  @PutMapping("/edit")
  public ResponseEntity<?> editPost(
    @Validated({EmailCheck.class, NicknameCheck.class})
    @ModelAttribute Users user,
    BindingResult br,
    @RequestParam(value = "profileImg", required = false) MultipartFile file,
    @AuthenticationPrincipal CustomUser loginUser
  ) throws Exception {
    log.info("회원 정보 수정 요청 user : {}", user);

    try {

      Users reqUser = userService.selectById(loginUser.getId());
      user.setId(loginUser.getId());

      Map<String, Object> response = new HashMap<>();

      // 닉네임 유효성 검사
      if (br.hasFieldErrors("nickname")) {
          response.put("nickError", true);
          return ResponseEntity.badRequest().body(response);
      }

      // 닉네임 중복 검사
      boolean isNicknameDuplicated = userService.findByNickname(user.getNickname());
      if (!reqUser.getNickname().equals(user.getNickname()) && isNicknameDuplicated) {
          response.put("nickDuple", true);
          return ResponseEntity.badRequest().body(response);
      }

      // 이메일 유효성 검사
      if (br.hasFieldErrors("email")) {
          response.put("emailError", true);
          return ResponseEntity.badRequest().body(response);
      }

      // 이메일 중복 검사
      String existingUserId = userService.findId(user.getEmail());
      if (!reqUser.getEmail().equals(user.getEmail()) && existingUserId != null) {
          response.put("emailDuple", true);
          return ResponseEntity.badRequest().body(response);
      }

      // 배지 텍스트 없이 보내면
      if(user.getCurrentBadge() == null || user.getCurrentBadge() == 0 ) user.setCurrentBadge(null);

      boolean checkBagde = badgeService.checkBadge(loginUser.getId(), user.getCurrentBadge());
      if(!checkBagde) user.setCurrentBadge(null);

      // 이미지 파일 저장
      if (file != null && !file.isEmpty()) {
        UploadImage.uploadProfileImage(file, user);
      }

      boolean result = userService.updateFromUser(user);
      response.put("user", user);
      response.put("success", true);
      if(result) return new ResponseEntity<>(response, HttpStatus.OK);
    } catch(Exception e) {
      e.printStackTrace();
    }

    return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
  }

  /**
   * 내 활동 페이지 요청
   * @return
   * @throws Exception
   */
  @GetMapping("/activity")
  public ResponseEntity<?> activity(
    @AuthenticationPrincipal CustomUser loginUser
    ) throws Exception {
    if(loginUser == null) return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);

    try {
      // 로그인 유저 정보
      Users user = userService.select(loginUser.getUsername());
      // 유저가 쓴 앨범 리뷰 정보
      List<AlbumReview> aReviewList = albumReviewServcie.reviewWithReviewerByUserId(loginUser.getId(), "", 0, 20);
      int countAReview = albumReviewServcie.countAlbumReview(loginUser.getId());
      // 유저가 좋아요 한 앨범 리뷰 정보
      List<AlbumReview> laReviewList = albumReviewServcie.likedReviewByUserId(loginUser.getId(), "", 0, 20);
      int countLaReview = albumReviewServcie.countLikedAlbumReview(loginUser.getId());
      // 유저가 쓴 트랙 리뷰 정보
      List<TrackReview> tReviewList = trackReviewService.reviewWithReviewerByUserId(loginUser.getId(), "", 0, 20);
      int countTReview = trackReviewService.countTrackReview(loginUser.getId());
      // 유저가 좋아요 한 트랙 리뷰 정보
      List<TrackReview> ltReviewList = trackReviewService.likedReviewByUserId(loginUser.getId(), "", 0, 20);
      int countLtReview = trackReviewService.countLikedTrackReview(loginUser.getId());
      // 총 리뷰 수, 좋아요 수
      UsersTotalLikes utl = userService.usersTotalLikes(loginUser.getId());

      Map<String, Object> response = new HashMap<>();

      response.put("utl", utl);
      response.put("aReviewList", aReviewList);
      response.put("countAReview", countAReview);
      response.put("laReviewList", laReviewList);
      response.put("countLaReview", countLaReview);
      response.put("tReviewList", tReviewList);
      response.put("countTReview", countTReview);
      response.put("ltReviewList", ltReviewList);
      response.put("countLtReview", countLtReview);
      response.put("user", user);
      response.put("lastPath", "activity");

      return new ResponseEntity<>(response, HttpStatus.OK);
    } catch(Exception e) {
      e.printStackTrace();
    }

    return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
  }

  /**
   * 유저의 리뷰 추가 요청
   * @param loingUser
   * @param data
   * @return
   * @throws Exception
   */
  @PostMapping("/activity")
  public ResponseEntity<?> usersTrackReview (
      @AuthenticationPrincipal CustomUser loingUser,
      @RequestBody Map<String, Object> data
    ) throws Exception {
      Long userId = loingUser.getId();
      String keyword = data.get("keyword").toString();
      int offset = Integer.parseInt(data.get("offset").toString());
      int limit = Integer.parseInt(data.get("limit").toString());
      String type = data.get("type").toString();

      log.info("type : {}", type);

      if(type.equals("tr")) {
        List<TrackReview> trackReviewList = trackReviewService.reviewWithReviewerByUserId(userId, keyword, offset, limit);
        if(trackReviewList != null)
              return new ResponseEntity<>(trackReviewList, HttpStatus.OK);
      }
      else if(type.equals("ltr")) {
        List<TrackReview> likedTrackReviewList = trackReviewService.likedReviewByUserId(userId, keyword, offset, limit);
        if(likedTrackReviewList != null)
              return new ResponseEntity<>(likedTrackReviewList, HttpStatus.OK);
      }
      else if(type.equals("ar")) {
        List<AlbumReview> albumReviewList = albumReviewServcie.reviewWithReviewerByUserId(userId, keyword, offset, limit);
        if(albumReviewList != null)
              return new ResponseEntity<>(albumReviewList, HttpStatus.OK);
      }
      else if(type.equals("lar")) {
        List<AlbumReview> likedAlbumReviewList = albumReviewServcie.likedReviewByUserId(userId, keyword, offset, limit);
        if(likedAlbumReviewList != null)
              return new ResponseEntity<>(likedAlbumReviewList, HttpStatus.OK);
      }

      return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
    }

  /**
   * 알림함 페이지 요청
   * @param loginUser
   * @return
   * @throws Exception
   */
  @GetMapping("/notifications")
  public ResponseEntity<?> notiList(
    @AuthenticationPrincipal CustomUser loginUser
    ) throws Exception {
      List<Notification> notiList = notificationService.findByUser(loginUser.getId());
      int count = notificationService.countUnread(loginUser.getId());
      Map<String, Object> response = new HashMap<>();

      response.put("count", count);
      response.put("notiList", notiList);
      response.put("lastPath", "noti");
      return new ResponseEntity<>(response, HttpStatus.OK);
  }

  /**
   * 알림 설정 페이지 요청
   * @return
   * @throws Exception
   */
  @GetMapping("/notifications/status")
  public ResponseEntity<?> getMethodName(
    @AuthenticationPrincipal CustomUser loginUser
  ) throws Exception {
    if(loginUser == null) return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
    // 알림 리스트
    List<UserNoti> notiList = userService.getNotiStatus(loginUser.getId());
    // 알림 한글화
    Map<String, String> notiType = Map.of(
      "comment", "댓글",
      "follow", "팔로우",
      "like", "좋아요",
      "reply", "답글",
      "badge", "배지",
      "announcement", "공지사항",
      "system", "시스템",
      "qna", "QnA",
      "mention", "언급"
      );

    Map<String, Object> response = new HashMap<>();

    response.put("notiType", notiType);
    response.put("notiList", notiList);
    response.put("lastPath", "alarm");
    return new ResponseEntity<>(response, HttpStatus.OK);
  }

  @PutMapping("/notifications/status")
  public ResponseEntity<?> putMethodName(
    @AuthenticationPrincipal CustomUser loginUser,
    @RequestBody UserNoti userNoti
  ) throws Exception {
    if(loginUser == null) return new ResponseEntity<>("권한이 없습니다.", HttpStatus.FORBIDDEN);
    userNoti.setUserId(loginUser.getId());
    log.info("userNOti : {}", userNoti);

    try {
      boolean result =  userService.changeNoti(userNoti);
      if(result)
        return new ResponseEntity<>("알림 설정 완료.", HttpStatus.OK);
    } catch(Exception e) {
      e.printStackTrace();
    }

    return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
  }

  /**
   * 아티스트 팔로우 페이지 요청
   * @param request
   * @return
   * @throws Exception
   */
  @GetMapping({"follow-artist", "/{id}/follow-artist"})
  public ResponseEntity<?> followArtists(
    @AuthenticationPrincipal CustomUser loginUser,
    @PathVariable(value = "id", required = false) Long id
  ) throws Exception {

    if(id == null && loginUser == null) return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);

    try {
      // 관리자 체크
      boolean isAdmin = userService.selectById(id != null ? id : loginUser.getId()).getAuthList().stream().anyMatch(auth -> "ROLE_ADMIN".equals(auth.getAuth()));
      if(isAdmin) return new ResponseEntity<>(HttpStatus.FORBIDDEN);

      // PathVariable 검사
      Long targetId = (id != null) ? id : loginUser.getUser().getId();
      // 자기 자신인지
      boolean isOwner = loginUser != null && loginUser.getId().equals(targetId);
      // 팔로우한 아티스트 리스트
      List<Artist> artistList = artistService.followingArtists(targetId, "", 0, 20);
      // 팔로우한 아티스트 수
      int count = artistService.countFollowingArtists(targetId);

      Map<String, Object> response = new HashMap<>();

      response.put("count", count);
      response.put("userId", targetId);
      response.put("artistList", artistList);
      response.put("isOwner", isOwner);

      response.put("lastPath", "artist-follows");
      return new ResponseEntity<>(response, HttpStatus.OK);
    } catch(Exception e) {
      e.printStackTrace();
    }

    return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
  }

  /**
   * 플레이리스트 페이지 요청
   * @return
  * @throws Exception
   */
  @GetMapping({"playlists", "/{id}/playlists"})
  public ResponseEntity<?> playlist(
      @AuthenticationPrincipal CustomUser loginUser,
      @PathVariable(value = "id", required = false) Long id
  ) throws Exception {

    if(id == null && loginUser == null) return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);

    try {
      // 관리자 체크
      boolean isAdmin = userService.selectById(id != null ? id : loginUser.getId()).getAuthList().stream().anyMatch(auth -> "ROLE_ADMIN".equals(auth.getAuth()));
      if(isAdmin) return new ResponseEntity<>(HttpStatus.FORBIDDEN);

      // PathVariable 검사
      Long targetId = (id != null) ? id : loginUser.getUser().getId();
      // 자기 자신인지
      boolean isOwner = loginUser != null && loginUser.getId().equals(targetId);

      List<Playlist> myPlaylists = playlistService.usersPlaylist(targetId);
      List<Playlist> likedPlaylists = playlistService.likedPlaylist(targetId, "", 0, 20);

      Map<String, Object> response = new HashMap<>();

      response.put("userId", targetId);
      response.put("isOwner", isOwner);
      response.put("myPlaylists", myPlaylists);
      response.put("likedPlaylists", likedPlaylists);
      response.put("lastPath", "playlist");

      return new ResponseEntity<>(response, HttpStatus.OK);
      } catch(Exception e) {
        e.printStackTrace();
      }

      return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
  }

  /**
   * 좋아요 한 앨범/트랙 페이지 요청
   * @param request
   * @return
   * @throws Exception
   */
  @GetMapping({"liked-music", "/{id}/liked-music"})
  public ResponseEntity<?> likedMusic(
    @AuthenticationPrincipal CustomUser loginUser,
    @PathVariable(value = "id", required = false) Long id
  ) throws Exception {

    if(id == null && loginUser == null) return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);

    try {
      // 관리자 체크
      boolean isAdmin = userService.selectById(id != null ? id : loginUser.getId()).getAuthList().stream().anyMatch(auth -> "ROLE_ADMIN".equals(auth.getAuth()));
      if(isAdmin) return new ResponseEntity<>(HttpStatus.FORBIDDEN);
      // PathVariable 검사
      Long targetId = (id != null) ? id : loginUser.getUser().getId();
      // 자기 자신인지
      boolean isOwner = loginUser != null && loginUser.getId().equals(targetId);
      // 좋아요한 앨범 + 수
      List<Album> likedAlbumList = albumService.likedAlbums(targetId, "", 0, 20);
      int countAlbum = albumService.countLikedAlbums(targetId);
      // 좋아요한 트랙 + 수
      List<Track> likedTrackList = trackService.likedTracks(targetId, "", 0, 20);
      int countTrack = trackService.countLikedTracks(targetId);

      Map<String, Object> response = new HashMap<>();

      response.put("userId", targetId);
      response.put("lastPath", "liked-music");
      response.put("isOwner", isOwner);
      response.put("likedAlbumList", likedAlbumList);
      response.put("countAlbum", countAlbum);
      response.put("likedTrackList", likedTrackList);
      response.put("countTrack", countTrack);

      return new ResponseEntity<>(response, HttpStatus.OK);
    } catch (Exception e) {
      e.printStackTrace();
    }

    return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
  }

  /**
   * 유저 팔로우 페이지 요청
   * @param request
   * @return
   * @throws Exception
   */
  @GetMapping({"follow-user", "/{id}/follow-user"})
  public ResponseEntity<?> followUsers(
    @AuthenticationPrincipal CustomUser loginUser,
    @PathVariable(value = "id", required = false) Long id
  ) throws Exception {

    if(id == null && loginUser == null) return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);

    try {
      // 관리자 체크
      boolean isAdmin = userService.selectById(id != null ? id : loginUser.getId()).getAuthList().stream().anyMatch(auth -> "ROLE_ADMIN".equals(auth.getAuth()));
      if(isAdmin) return new ResponseEntity<>(HttpStatus.FORBIDDEN);
      // PathVariable 검사
      Long targetId = (id != null) ? id : loginUser.getUser().getId();
      // 자기 자신인지
      boolean isOwner = loginUser != null && loginUser.getId().equals(targetId);
      // 팔로우, 팔로워 정보
      List<Users> myFollower = userFollowService.myFollower(targetId, "", 0, 20);
      int followerCount = userFollowService.myFollowerCount(targetId);
      List<Users> myFollow = userFollowService.myFollow(targetId, "", 0, 20);
      int followCount = userFollowService.myFollowCount(targetId);

      Map<String, Object> response = new HashMap<>();

      response.put("userId", targetId);
      response.put("myFollower", myFollower);
      response.put("myFollow", myFollow);
      response.put("followerCount", followerCount);
      response.put("followCount", followCount);
      response.put("lastPath", "user-follows");
      response.put("isOwner", isOwner);

      return new ResponseEntity<>(response, HttpStatus.OK);

    } catch (Exception e) {
      e.printStackTrace();
    }

    return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
  }

  /**
   * 배지 페이지 요청
   * @param loginUser
   * @return
   * @throws Exception
   */
  @GetMapping("/badge")
  public ResponseEntity<?> badge(
    @AuthenticationPrincipal CustomUser loginUser
  ) throws Exception {
    if(loginUser == null) return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);

    try {
      // 획득 배지 리스트
      List<Badge> haveBagdeList = badgeService.haveBadge(loginUser.getId());
      // 미획득 배지 리스트
      List<Badge> notHaveBadgeList = badgeService.doesNotHaveBadge(loginUser.getId());

      Map<String, Object> response = new HashMap<>();

      response.put("lastPath", "badge");
      response.put("haveBagdeList", haveBagdeList);
      response.put("notHaveBadgeList", notHaveBadgeList);

      return new ResponseEntity<>(response, HttpStatus.OK);

    } catch(Exception e) {
      e.printStackTrace();
    }

    return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
  }

  // /**
  //  * 계정 / 보안 페이지 요청
  //  * @param loginUser
  //  * @return
  //  * @throws Exception
  //  */
  // @GetMapping("/security")
  // public ResponseEntity<?> security(
  //   @AuthenticationPrincipal CustomUser loginUser
  // ) throws Exception {
  //   // 로그인 유저 정보
  //   Users user = userService.select(loginUser.getUsername());
  //   Boolean success = (Boolean) model.asMap().get("success");
  //   log.info("success : {}", success);

  //   Map<String, Object> response = new HashMap<>();

  //   if(success != null) {
  //     response.put("vali", success);
  //   } else {
  //     response.put("vali", false);
  //   }
  //   response.put("lastPath", "security");
  //   response.put("user", user);

  //   return new ResponseEntity<>(response, HttpStatus.OK);
  // }

  /**
   * 비밀번호 체크 요청
   * @param loginUser
   * @param password
   * @return
   * @throws Exception
   */
  @PostMapping("/check-password")
  public ResponseEntity<?> checkPassword(
    @AuthenticationPrincipal CustomUser loginUser,
    @RequestParam("password") String password,
    RedirectAttributes redirectAttributes
    ) throws Exception {
      if(loginUser == null) return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);

      String dbPassword =  userService.selectPasswordById(loginUser.getId());
      boolean result = userService.comparePassword(password, dbPassword);
      log.info("checkId : {}", result);

      if(result) {
        // redirectAttributes.addFlashAttribute("success", true);
        return new ResponseEntity<>(HttpStatus.OK);
      } else {
        return new ResponseEntity<>("비밀번호가 일치하지 않음.", HttpStatus.BAD_REQUEST);
      }
  }

  /**
   * 비밀번호 변경 요청
   * @param loginUser
   * @param password
   * @return
   * @throws Exception
   */
  @PostMapping("/change-password")
  public ResponseEntity<?> changePassword(
    @AuthenticationPrincipal CustomUser loginUser,
    @Validated(PasswordCheck.class) @ModelAttribute Users user,
    BindingResult br,
    @RequestParam("password2") String password2
    ) throws Exception {
    if(loginUser == null) return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
    String password = user.getPassword();
    log.info("password : {}", password);

    if(br.hasErrors())
      return new ResponseEntity<>("invalid", HttpStatus.BAD_REQUEST);

    if(!password.equals(password2))
      return new ResponseEntity<>("different", HttpStatus.BAD_REQUEST);

    boolean result = userService.changePassword(password, loginUser.getId());
    if(result)
      return new ResponseEntity<>(HttpStatus.OK);

    return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
  }

  @DeleteMapping("")
  public ResponseEntity<?> withdrawal(
    @AuthenticationPrincipal CustomUser loginUser
  ) throws Exception {
    if(loginUser == null) return new ResponseEntity<>("권한이 없습니다.", HttpStatus.UNAUTHORIZED);
    boolean result = userService.enableUser(loginUser.getId(), false);
    if(result) return new ResponseEntity<>("회원탈퇴 처리되었습니다.", HttpStatus.OK);

    return new ResponseEntity<>("서버 오류.", HttpStatus.INTERNAL_SERVER_ERROR);
  }

}
