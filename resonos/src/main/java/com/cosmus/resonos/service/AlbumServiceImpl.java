package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.mapper.AlbumMapper;

@Service
public class AlbumServiceImpl implements AlbumService{
    private final AlbumMapper albumMapper;

    public AlbumServiceImpl(AlbumMapper albumMapper) {
        this.albumMapper = albumMapper;
    }

    @Override
    public List<Album> getAllAlbums() {
        return albumMapper.selectAll();
    }

    @Override
    public Album getAlbumById(String id) {
        return albumMapper.selectById(id);
    }

    @Override
    public boolean addAlbum(Album album) {
        return albumMapper.insert(album) > 0;
    }

    @Override
    public boolean updateAlbum(Album album) {
        return albumMapper.update(album) > 0;
    }

    @Override
    public boolean deleteAlbum(String id) {
        return albumMapper.delete(id) > 0;
    }
}
