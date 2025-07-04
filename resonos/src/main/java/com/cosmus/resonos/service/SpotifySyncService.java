package com.cosmus.resonos.service;

import java.util.Map;

public interface SpotifySyncService {
   public void saveArtistIfNotExists(Map<String, Object> artistData) throws Exception;
   public void saveAlbumIfNotExists(Map<String, Object> albumData, String artistId) throws Exception;
   public void saveTrackIfNotExists(Map<String, Object> trackData, String albumId, String artistId) throws Exception;

    // 전체 동기화: 아티스트 → 앨범 → 트랙
    public void syncArtistAndAlbumsAndTracks(String spotifyArtistId, String accessToken) throws Exception;
}
