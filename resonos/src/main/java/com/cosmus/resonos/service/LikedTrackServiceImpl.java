package com.cosmus.resonos.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.LikedTrack;
import com.cosmus.resonos.mapper.LikedTrackMapper;

@Service
public class LikedTrackServiceImpl implements LikedTrackService {

    @Autowired
    private LikedTrackMapper likedTrackMapper;

    @Override
    public List<LikedTrack> list() throws Exception {
        return likedTrackMapper.list();
    }

    @Override
    public LikedTrack select(Long id) throws Exception {
        return likedTrackMapper.select(id);
    }

    @Override
    public boolean insert(LikedTrack likedTrack) throws Exception {
        return likedTrackMapper.insert(likedTrack) > 0;
    }

    @Override
    public boolean update(LikedTrack likedTrack) throws Exception {
        return likedTrackMapper.update(likedTrack) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return likedTrackMapper.delete(id) > 0;
    }
}
