package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.Track;

public interface TrackService {
    List<Track> getAllTracks();
    Track getTrackById(String id);
    boolean addTrack(Track track);
    boolean updateTrack(Track track);
    boolean deleteTrack(String id);  
}
