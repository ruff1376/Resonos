package com.cosmus.resonos.service;

import java.util.List;

import com.cosmus.resonos.domain.Artist;

public interface ArtistService {
    List<Artist> getAllArtists();
    Artist getArtistById(String id);
    boolean addArtist(Artist artist);
    boolean updateArtist(Artist artist);
    boolean deleteArtist(String id);
} 
