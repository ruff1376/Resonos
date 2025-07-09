package com.cosmus.resonos.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.domain.CustomUser;
import com.cosmus.resonos.domain.Playlist;
import com.cosmus.resonos.domain.PublicUserDto;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.domain.Users;
import com.cosmus.resonos.service.AlbumService;
import com.cosmus.resonos.service.ArtistService;
import com.cosmus.resonos.service.PlaylistService;
import com.cosmus.resonos.service.TrackService;
import com.cosmus.resonos.service.UserFollowService;
import com.cosmus.resonos.service.UserService;
import com.cosmus.resonos.util.UploadImage;

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
    @RequestParam(value = "success", required = false) String success
  ) throws Exception {
    Users user = userService.select(loginUser.getUsername());
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
    @ModelAttribute Users user,
    @RequestParam("profileImg") MultipartFile file,
    @AuthenticationPrincipal CustomUser loginUser
  ) throws Exception {

    user.setId(loginUser.getUser().getId());

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
   */
  @GetMapping("/activity")
  // TODO: @AuthenticationPrincipal 로 접근 권한
  public String activity(Model model) {

    model.addAttribute("lastPath", "activity");
    return "user/activity";
  }

  @GetMapping("/badge")
  // TODO: @AuthenticationPrincipal 로 접근 권한
  public String badge(Model model) {

    model.addAttribute("lastPath", "badge");
    return "user/badge";
  }

  @GetMapping("/setting-alarm")
  public String getMethodName(Model model) {


    model.addAttribute("lastPath", "setting-alarm");
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
    List<Artist> artistList = artistService.followingArtists(targetId);

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
    List<Album> likedAlbumList = albumService.likedAlbums(targetId);
    List<Track> likedTrackList = trackService.likedTracks(targetId);

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
    List<Users> myFollower = userFollowService.myFollower(targetId);
    List<Users> myFollow = userFollowService.myFollow(targetId);

    model.addAttribute("myFollower", myFollower);
    model.addAttribute("myFollow", myFollow);
    model.addAttribute("lastPath", "user-follows");
    model.addAttribute("isOwner", isOwner);
    return "user/follow_user";
  }
}
