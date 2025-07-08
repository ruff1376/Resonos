package com.cosmus.resonos.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Playlist;
import com.cosmus.resonos.domain.PlaylistDTO;
import com.cosmus.resonos.domain.PlaylistDetail;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.mapper.PlaylistMapper;

@Service
public class PlaylistServiceImpl implements PlaylistService {

    private final PlaylistMapper playlistMapper;

    public PlaylistServiceImpl(PlaylistMapper playlistMapper) {
        this.playlistMapper = playlistMapper;
    }

    @Override
    public List<Playlist> list() throws Exception {
        return playlistMapper.list();
    }

    @Override
    public Playlist select(Long id) throws Exception {
        return playlistMapper.select(id);
    }

    @Override
    public boolean insert(Playlist playlist) throws Exception {
        return playlistMapper.insert(playlist) > 0;
    }

    @Override
    public boolean update(Playlist playlist) throws Exception {
        return playlistMapper.update(playlist) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return playlistMapper.delete(id) > 0;
    }

    @Override
    public List<Playlist> usersPlaylist(Long userId) throws Exception {
        return playlistMapper.usersPlaylist(userId);
    }

    @Override
    public List<Playlist> usersPlaylist3(Long userId) throws Exception {
        return playlistMapper.usersPlaylist3(userId);
    }

    @Override
    public List<Playlist> likedPlaylist(Long userId) throws Exception {
        return playlistMapper.likedPlaylist(userId);
    }

    @Override
    public PlaylistDTO trackOfPlaylist(Long playlistId) throws Exception {
        return playlistMapper.trackOfPlaylist(playlistId);
    }

    @Override
    public boolean updateTrackOrder(Long playlistId, List<Map<String, Object>> orderList) throws Exception {
        return playlistMapper.updateTrackOrder(playlistId, orderList) > 0 ? true : false;
    }

    @Override
    public boolean deleteTracks(Long playlistId, int orderNo) throws Exception {
        return playlistMapper.deleteTracks(playlistId, orderNo) > 0 ? true : false;
    }

    @Override
    public int getMaxOrderNo(Long playlistId) throws Exception {
        return playlistMapper.getMaxOrderNo(playlistId);
    }

    @Override
    public boolean updateTrackOrderNo(Long playlistId, List<Track> trackList) throws Exception {
        return playlistMapper.updateTrackOrderNo(playlistId, trackList) > 0 ? true : false;
    }

    @Override
    public boolean insertTracks(List<PlaylistDetail> playlistDetail) throws Exception {
        return playlistMapper.insertTracks(playlistDetail) > 0 ? true : false;
    }
}
