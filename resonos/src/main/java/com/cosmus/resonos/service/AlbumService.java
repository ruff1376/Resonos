package com.cosmus.resonos.service;

import java.util.List;

import com.cosmus.resonos.domain.Album;

public interface AlbumService {
    List<Album> getAllAlbums();
    Album getAlbumById(String id);
    boolean addAlbum(Album album);
    boolean updateAlbum(Album album);
    boolean deleteAlbum(String id);  
}
