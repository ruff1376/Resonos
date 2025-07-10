package com.cosmus.resonos.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.Playlist;
import com.cosmus.resonos.domain.PlaylistDTO;
import com.cosmus.resonos.domain.PlaylistDetail;
import com.cosmus.resonos.domain.Track;

@Mapper
public interface PlaylistMapper {
    // 전체 조회
    public List<Playlist> list() throws Exception;
    // 조회
    public Playlist select(@Param("id") Long id) throws Exception;
    // 삽입
    public int insert(Playlist playlist) throws Exception;
    // 수정
    public int update(Playlist playlist) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;

    /* 마이페이지 */
    // 특정 유저의 플레이리스트 전체 조회
    public List<Playlist> usersPlaylist(Long userId) throws Exception;
    // 특정 유저의 플레이리스트 3개 조회
    public List<Playlist> usersPlaylist3(Long userId) throws Exception;
    // 특정 유저의 공개 플레이리스트 전체 조회
    public List<Playlist> publicUsersPlaylist(Long userId) throws Exception;
    // 특정 유저의 공개 플레이리스트 3개 조회
    public List<Playlist> publicUsersPlaylist3(Long userId) throws Exception;
    // 좋아요한 플레이리스트 조회
    public List<Playlist> likedPlaylist(Long userId) throws Exception;
    // 플레이리스트 상세 조회
    public PlaylistDTO trackOfPlaylist(Long playlistId) throws Exception;
    // oreder_no MAX 조회
    public int getMaxOrderNo(@Param("playlistId") Long playlistId) throws Exception;
    // order_no 재정렬
    public int updateTrackOrderNo(@Param("playlistId") Long playlistId, @Param("list") List<Track> trackList) throws Exception;
    // 플레이리스트 트랙 순서 변경
    public int updateTrackOrder(@Param("playlistId") Long playlistId, @Param("orderList") List<Map<String, Object>> orderList) throws Exception;
    // 플레이리스트 트랙 삭제
    public int deleteTracks(@Param("playlistId") Long playlistId, @Param("orderNo") int orderNo) throws Exception;
    // 플레이리스트 트랙 추가
    public int insertTracks(List<PlaylistDetail> playlistDetail) throws Exception;
    // 플레이리스트 좋아요
    public int likePlaylist(@Param("loginUserId") Long loginUserId, @Param("playlistId") Long playlistId) throws Exception;
    // 플레이리스트 좋아요 취소
    public int cancleLikePlaylist(@Param("loginUserId") Long loginUserId, @Param("playlistId") Long playlistId) throws Exception;
    // 플레이리스트 좋아요 유무
    public int alreadyLikedPlaylist(@Param("loginUserId") Long loginUserId, @Param("playlistId") Long playlistId) throws Exception;
}

