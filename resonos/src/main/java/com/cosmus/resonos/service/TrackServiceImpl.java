package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cosmus.resonos.mapper.TrackMapper;
import com.cosmus.resonos.domain.Track;

@Service
public class TrackServiceImpl implements TrackService{
    private final TrackMapper trackMapper;

    public TrackServiceImpl(TrackMapper trackMapper) {
        this.trackMapper = trackMapper;
    }

    @Override
    public List<Track> getAllTracks() {
        return trackMapper.selectAll();
    }

    @Override
    public Track getTrackById(String id) {
        return trackMapper.selectById(id);
    }

    @Override
    public boolean addTrack(Track track) {
        return trackMapper.insert(track) > 0;
    }

    @Override
    public boolean updateTrack(Track track) {
        return trackMapper.update(track) > 0;
    }

    @Override
    public boolean deleteTrack(String id) {
        return trackMapper.delete(id) > 0;
    }
}
