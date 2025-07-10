package com.cosmus.resonos.service;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface SpotifySyncService {
   public void saveArtistIfNotExists(Map<String, Object> artistData) throws Exception;
   public void saveAlbumIfNotExists(@Param("albumData") Map<String, Object> albumData, @Param("artistId") String artistId) throws Exception;
   public void saveTrackIfNotExists(@Param("trackData") Map<String, Object> trackData, @Param("albumId") String albumId, @Param("artistId") String artistId) throws Exception;

    // 전체 동기화: 아티스트 → 앨범 → 트랙
    public void syncArtistAndAlbumsAndTracks(@Param("spotifyArtistId") String spotifyArtistId, @Param("accessToken") String accessToken) throws Exception;
}
