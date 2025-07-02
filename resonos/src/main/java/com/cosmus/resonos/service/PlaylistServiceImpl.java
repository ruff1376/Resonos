package com.cosmus.resonos.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.Playlist;
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
}
