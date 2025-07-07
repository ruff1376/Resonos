package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.Playlist;
import com.cosmus.resonos.domain.PlaylistDTO;

public interface PlaylistService {
    // 전체 조회
    public List<Playlist> list() throws Exception;
    // 조회
    public Playlist select(Long id) throws Exception;
    // 삽입
    public boolean insert(Playlist playlist) throws Exception;
    // 수정
    public boolean update(Playlist playlist) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;


     /* 마이페이지 */
    // 특정 유저의 플레이리스트 3개 조회
    public List<Playlist> usersPlaylist(Long userId) throws Exception;
    // 특정 유저의 플레이리스트 전체 조회
    public List<Playlist> usersPlaylist3(Long userId) throws Exception;
    // 좋아요한 플레이리스트 조회
    public List<Playlist> likedPlaylist(Long userId) throws Exception;
    // 플레이리스트 상세 조회
    public PlaylistDTO trackOfPlaylist(Long playlistId) throws Exception;
}
