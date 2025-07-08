package com.cosmus.resonos.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.PlaylistDetail;
import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.mapper.PlaylistDetailMapper;

@Service
public class PlaylistDetailServiceImpl implements PlaylistDetailService {

    private final PlaylistDetailMapper playlistDetailMapper;

    public PlaylistDetailServiceImpl(PlaylistDetailMapper playlistDetailMapper) {
        this.playlistDetailMapper = playlistDetailMapper;
    }

    @Override
    public List<PlaylistDetail> list() throws Exception {
        return playlistDetailMapper.list();
    }

    @Override
    public PlaylistDetail select(Long id) throws Exception {
        return playlistDetailMapper.select(id);
    }

    @Override
    public boolean update(PlaylistDetail detail) throws Exception {
        return playlistDetailMapper.update(detail) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return playlistDetailMapper.delete(id) > 0;
    }

    @Override
    public boolean insert(List<PlaylistDetail> playlistDetail) throws Exception {
        return playlistDetailMapper.insert(playlistDetail) > 0 ? true : false;
    }

    @Override
    public int getMaxOrderNo(Long playlistId) throws Exception {
        return playlistDetailMapper.getMaxOrderNo(playlistId);
    }

    @Override
    public boolean updateTrackOrderNo(Long playlistId, List<Track> trackList) throws Exception {
        return playlistDetailMapper.updateTrackOrderNo(playlistId, trackList) > 0 ? true : false;
    }
}
