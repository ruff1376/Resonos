package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.domain.Badge;
import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.Playlist;
import com.cosmus.resonos.domain.PublicUserDto;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.domain.TrackReview;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.ArtistService;
import com.cosmus.resonos.service.BadgeService;
import com.cosmus.resonos.service.PlaylistService;
import com.cosmus.resonos.service.TrackReviewService;
import com.cosmus.resonos.service.TrackService;
import com.cosmus.resonos.service.UserFollowService;
import com.cosmus.resonos.service.UserService;
import com.cosmus.resonos.util.UploadImage;
import com.cosmus.resonos.validation.EmailCheck;
import com.cosmus.resonos.validation.NicknameCheck;
import com.cosmus.resonos.validation.PasswordCheck;

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

  @Autowired BadgeService badgeService;
  /**
   * 로그인 페이지 요청
   * @param param
   * @return
   */
  // @PostMapping("/login")
  // public String login(@RequestParam String param) {
  //     return new String();
  // }

  /**
   * 마이페이지 요청
   * @param model
   * @return
   * @throws Exception
   */
  @GetMapping("/mypage")
  public String mypage(
    Model model,
    @AuthenticationPrincipal CustomUser loginUser
    ) throws Exception {
    if(loginUser == null) return "redirect:/login";
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
    int badgeCount = badgeService.badgeCount(user.getId());

    model.addAttribute("badgeCount", badgeCount);
    model.addAttribute("badgeList", badgeList);
    model.addAttribute("currentBadge", currentBadge);
    model.addAttribute("artistList", artistList);
    model.addAttribute("trackList", trackList);
    model.addAttribute("albumList", albumList);
    model.addAttribute("loginUser", loginUser);
    model.addAttribute("playlists", playlists);
    model.addAttribute("user", user);
    model.addAttribute("followerCount", followerCount);
    model.addAttribute("followCount", followCount);
    model.addAttribute("email", user.getEmail());
    model.addAttribute("isOwner", true);
    return "user/mypage";
  }

  /**
   * 다른 유저의 마이페이지 요청
   * @param id
   * @param loginUser
   * @param model
   * @return
   * @throws Exception
   */
  @GetMapping("/{id}")
  public String userPage(
    @PathVariable("id") Long id,
    @AuthenticationPrincipal CustomUser loginUser,
    Model model) throws Exception {

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
    // TODO: 차트에 넘길 데이터

    /* SELECT a.genre, COUNT(*) AS like_count
    FROM liked_track lt
      JOIN track t ON lt.track_id = t.id
      JOIN album a ON t.album_id = a.id
    WHERE lt.user_id = 1
    GROUP BY a.genre
    ORDER BY like_count DESC; */

    // 자기 자신인지
    boolean isOwner = loginUser != null && loginUser.getId().equals(id);
    if(isOwner) {
      Users me = userService.selectById(id);
      model.addAttribute("user", me);
    } else {
      // 자기 자신이 아니면 공개 플레이리스트만
      playlists = playlistService.publicUsersPlaylist3(id);
      model.addAttribute("user", user);
    }

    model.addAttribute("badgeCount", badgeCount);
    model.addAttribute("badgeList", badgeList);
    model.addAttribute("currentBadge", currentBadge);
    model.addAttribute("alreadyFollow", alreadyFollow);
    model.addAttribute("artistList", artistList);
    model.addAttribute("trackList", trackList);
    model.addAttribute("albumList", albumList);
    model.addAttribute("followerCount", followerCount);
    model.addAttribute("followCount", followCount);
    model.addAttribute("playlists", playlists);
    model.addAttribute("isOwner", isOwner);

    if (loginUser != null) {
      model.addAttribute("loginUser", loginUser.getUser());
    }

    return "user/mypage";
  }

  /**
   * 회웑 정보 수정 페이지 요청
   * @param model
   * @return
   * @throws Exception
   *
   */
  @GetMapping("/edit")
  public String edit(
    @AuthenticationPrincipal CustomUser loginUser,
    Model model,
    @RequestParam(value = "success", required = false) String success,
    @RequestParam(value = "nickError", required = false) Boolean nickError,
    @RequestParam(value = "nickDuple", required = false) Boolean nickDuple,
    @RequestParam(value = "emailError", required = false) Boolean emailError
  ) throws Exception {
    if(loginUser == null) return "redirect:/login";
    Users user = userService.select(loginUser.getUsername());
    List<Badge> badgeList = badgeService.haveBadge(loginUser.getId());
    // 배지 정보
    Badge badge = badgeService.select(user.getCurrentBadge());
    String badgeName = badge == null ? "" : badge.getName();

    if(nickError != null) model.addAttribute("nickError", nickError);
    if(nickDuple != null) model.addAttribute("nickDuple", nickDuple);
    if(emailError != null) model.addAttribute("emailError", emailError);

    model.addAttribute("badgeName", badgeName);
    model.addAttribute("badgeList", badgeList);
    model.addAttribute("user", user);
    model.addAttribute("success", success);

    return "user/edit";
  }

  /**
   * 회원 정보 수정 요청
   * @param user
   * @return
   * @throws Exception
   */
  @PostMapping("/edit")
  public String editPost(
    @Validated({EmailCheck.class, NicknameCheck.class})
    @ModelAttribute Users user,
    BindingResult br,
    @RequestParam("profileImg") MultipartFile file,
    @AuthenticationPrincipal CustomUser loginUser,
    RedirectAttributes redirectAttributes
  ) throws Exception {
    log.info("회원 정보 수정 요청 user : {}", user);
    Users reqUser = userService.selectById(loginUser.getId());
    user.setId(loginUser.getId());

    // 닉네임 유효성 검사
    if(br.hasFieldErrors("nickname")) {
      redirectAttributes.addFlashAttribute("nickError", true);
      return "redirect:/users/edit?nickError";
    }

    // 닉네임 중복 검사
    boolean checkNickname = userService.findByNickname(user.getNickname());
    if(!reqUser.getNickname().equals(user.getNickname()) && checkNickname) {
      redirectAttributes.addFlashAttribute("nickDuple", true);
      return "redirect:/users/edit?nickDuple";
    }

    // 이메일 유효성 검사
    if(br.hasFieldErrors("email")) {
      redirectAttributes.addFlashAttribute("emailError", true);
      return "redirect:/users/edit?emailError";
    }

    // 배지 텍스트 없이 보내면
    if(user.getCurrentBadge() == 0) user.setCurrentBadge(null);

    boolean checkBagde = badgeService.checkBadge(loginUser.getId(), user.getCurrentBadge());
    if(!checkBagde) user.setCurrentBadge(null);

    // 이미지 파일 저장
    if (!file.isEmpty()) {
      UploadImage.uploadProfileImage(file, user);
    }

    boolean result = userService.updateFromUser(user);
    if(result) return "redirect:/users/edit?success=true";

    return "redirect:/users/edit?fail=true";
  }

  /**
   * 내 활동 페이지 요청
   * @param model
   * @return
   * @throws Exception
   */
  @GetMapping("/activity")
  public String activity(
    @AuthenticationPrincipal CustomUser loginUser,
    Model model
    ) throws Exception {
    if(loginUser == null) return "redirect:/login";
    // 로그인 유저 정보
    Users user = userService.select(loginUser.getUsername());
    // 유저가 쓴 리뷰 정보
    List<TrackReview> tReviewList = trackReviewService.reviewWithReviewerByUserId(loginUser.getId());
    // 유저가 좋아요 한 리뷰 정보
    List<TrackReview> ltReviewList = trackReviewService.likedReviewByUserId(loginUser.getId());

    model.addAttribute("ltReviewList", ltReviewList);
    model.addAttribute("tReviewList", tReviewList);
    model.addAttribute("user", user);
    model.addAttribute("lastPath", "activity");
    return "user/activity";
  }

  /**
   * 알림 설정
   * @param model
   * @return
   */
  @GetMapping("/alarm")
  public String getMethodName(Model model) {


    model.addAttribute("lastPath", "alarm");
    return "user/setting-alarm";
  }

  /**
   * 아티스트 팔로우 페이지 요청
   * @param model
   * @param request
   * @return
   * @throws Exception
   */
  @GetMapping({"follow-artist", "/{id}/follow-artist"})
  public String followArtists(
    @AuthenticationPrincipal CustomUser loginUser,
    @PathVariable(value = "id", required = false) Long id,
    Model model
  ) throws Exception {
    if(id == null && loginUser == null) return "redirect:/login";

    // PathVariable 검사
    Long targetId = (id != null) ? id : loginUser.getUser().getId();
    // 자기 자신인지
    boolean isOwner = loginUser != null && loginUser.getId().equals(targetId);
    // 팔로우한 아티스트 리스트
    List<Artist> artistList = artistService.followingArtists(targetId, "");

    model.addAttribute("userId", targetId);
    model.addAttribute("artistList", artistList);
    model.addAttribute("isOwner", isOwner);

    model.addAttribute("lastPath", "artist-follows");
    return "user/follow_artist";
  }

  /**
   * 플레이리스트 페이지 요청
   * @param model
   * @return
   * @throws Exception
   */
  @GetMapping({"playlists", "/{id}/playlists"})
  public String playlist(
      @AuthenticationPrincipal CustomUser loginUser,
      @PathVariable(value = "id", required = false) Long id,
      Model model
  ) throws Exception {
    if(id == null && loginUser == null) return "redirect:/login";

    // PathVariable 검사
    Long targetId = (id != null) ? id : loginUser.getUser().getId();
    // 자기 자신인지
    boolean isOwner = loginUser != null && loginUser.getId().equals(targetId);

    List<Playlist> myPlaylists = playlistService.usersPlaylist(targetId);
    List<Playlist> likedPlaylists = playlistService.likedPlaylist(targetId);

    model.addAttribute("isOwner", isOwner);
    model.addAttribute("myPlaylists", myPlaylists);
    model.addAttribute("likedPlaylists", likedPlaylists);
    model.addAttribute("lastPath", "playlist");
    return "user/playlist";
  }

  /**
   * 좋아요 한 앨범/트랙 페이지 요청
   * @param model
   * @param request
   * @return
   * @throws Exception
   */
  @GetMapping({"liked-music", "/{id}/liked-music"})
  public String likedMusic(
    @AuthenticationPrincipal CustomUser loginUser,
    @PathVariable(value = "id", required = false) Long id,
    Model model
  ) throws Exception {
    if(id == null && loginUser == null) return "redirect:/login";

    // PathVariable 검사
    Long targetId = (id != null) ? id : loginUser.getUser().getId();
    // 자기 자신인지
    boolean isOwner = loginUser != null && loginUser.getId().equals(targetId);
    List<Album> likedAlbumList = albumService.likedAlbums(targetId, "");
    List<Track> likedTrackList = trackService.likedTracks(targetId, "");

    model.addAttribute("userId", targetId);
    model.addAttribute("lastPath", "liked-music");
    model.addAttribute("isOwner", isOwner);
    model.addAttribute("likedAlbumList", likedAlbumList);
    model.addAttribute("likedTrackList", likedTrackList);
    return "user/liked_music";
  }

  /**
   * 유저 팔로우 페이지 요청
   * @param model
   * @param request
   * @return
   * @throws Exception
   */
  @GetMapping({"follow-user", "/{id}/follow-user"})
  public String followUsers(
    Model model,
    @AuthenticationPrincipal CustomUser loginUser,
    @PathVariable(value = "id", required = false) Long id
  ) throws Exception {
    if(id == null && loginUser == null) return "redirect:/login";

    // PathVariable 검사
    Long targetId = (id != null) ? id : loginUser.getUser().getId();
    // 자기 자신인지
    boolean isOwner = loginUser != null && loginUser.getId().equals(targetId);
    // 팔로우, 팔로워 정보
    List<Users> myFollower = userFollowService.myFollower(targetId, "");
    List<Users> myFollow = userFollowService.myFollow(targetId, "");

    model.addAttribute("userId", targetId);
    model.addAttribute("myFollower", myFollower);
    model.addAttribute("myFollow", myFollow);
    model.addAttribute("lastPath", "user-follows");
    model.addAttribute("isOwner", isOwner);
    return "user/follow_user";
  }

  /**
   * 배지 페이지 요청
   * @param loginUser
   * @param model
   * @return
   * @throws Exception
   */
  @GetMapping("/badge")
  public String badge(
    @AuthenticationPrincipal CustomUser loginUser,
    Model model
  ) throws Exception {
    if(loginUser == null) return "redirect:/login";
    // 로그인 유저 정보
    Users user = userService.select(loginUser.getUsername());
    // 획득 배지 리스트
    List<Badge> haveBagdeList = badgeService.haveBadge(loginUser.getId());
    // 미획득 배지 리스트
    List<Badge> notHaveBadgeList = badgeService.doesNotHaveBadge(loginUser.getId());

    model.addAttribute("lastPath", "badge");
    model.addAttribute("haveBagdeList", haveBagdeList);
    model.addAttribute("notHaveBadgeList", notHaveBadgeList);
    return "user/badge";
  }

  /**
   * 계정 / 보안 페이지 요청
   * @param loginUser
   * @param model
   * @return
   * @throws Exception
   */
  @GetMapping("/security")
  public String security(
    @AuthenticationPrincipal CustomUser loginUser,
    Model model
  ) throws Exception {
    // 로그인 유저 정보
    Users user = userService.select(loginUser.getUsername());
    Boolean success = (Boolean) model.asMap().get("success");
    log.info("success : {}", success);
    if(success != null) {
      model.addAttribute("vali", success);
    } else {
      model.addAttribute("vali", false);
    }
    model.addAttribute("lastPath", "security");
    model.addAttribute("user", user);
    return "user/security";
  }

  /**
   * 비밀번호 체크 요청
   * @param loginUser
   * @param password
   * @param model
   * @return
   * @throws Exception
   */
  @PostMapping("/check-password")
  public String checkPassword(
    @AuthenticationPrincipal CustomUser loginUser,
    @RequestParam("password") String password,
    RedirectAttributes redirectAttributes,
    Model model
    ) throws Exception {
      if(loginUser == null) return "redirect:/login";

      String dbPassword =  userService.selectPasswordById(loginUser.getId());
      boolean result = userService.comparePassword(password, dbPassword);
      log.info("checkId : {}", result);
      if(result) {
        redirectAttributes.addFlashAttribute("success", true);
        return "redirect:/users/security?success";
      }

      redirectAttributes.addFlashAttribute("success", false);
      return "redirect:/users/security?fail";
  }

  /**
   * 비밀번호 변경 요청
   * @param loginUser
   * @param password
   * @param redirectAttributes
   * @param model
   * @return
   * @throws Exception
   */
  @PostMapping("/change-password")
  public String changePassword(
    @AuthenticationPrincipal CustomUser loginUser,
    @Validated(PasswordCheck.class) @ModelAttribute Users user,
    BindingResult br,
    @RequestParam("password2") String password2,
    RedirectAttributes redirectAttributes,
    Model model
    ) throws Exception {
    if(loginUser == null) return "redirect:/login";
    String password = user.getPassword();
    log.info("password : {}", password);
    redirectAttributes.addFlashAttribute("success", true);

    if(br.hasErrors()) {
      return "redirect:/users/security?error";
    }

    if(!password.equals(password2))
    return "redirect:/users/security?diff";

    boolean result = userService.changePassword(password, loginUser.getId());
    if(result)
      return "redirect:/users/security?complete";

    return "redirect:/users/security?fail";
  }

}
