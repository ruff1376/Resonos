package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.mapper.ArtistMapper;

@Service
public class ArtistServiceImpl implements ArtistService{
private final ArtistMapper artistMapper;

    public ArtistServiceImpl(ArtistMapper artistMapper) {
        this.artistMapper = artistMapper;
    }

    @Override
    public List<Artist> getAllArtists() {
        return artistMapper.selectAll();
    }

    @Override
    public Artist getArtistById(String id) {
        return artistMapper.selectById(id);
    }

    @Override
    public boolean addArtist(Artist artist) {
        return artistMapper.insert(artist) > 0;
    }

    @Override
    public boolean updateArtist(Artist artist) {
        return artistMapper.update(artist) > 0;
    }

    @Override
    public boolean deleteArtist(String id) {
        return artistMapper.delete(id) > 0;
    }
}
