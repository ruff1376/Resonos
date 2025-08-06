package com.cosmus.resonos.service.user;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.review.LikedPlaylist;
import com.cosmus.resonos.mapper.user.LikedPlaylistMapper;

@Service
public class LikedPlaylistServiceImpl implements LikedPlaylistService {

    @Autowired
    private LikedPlaylistMapper likedPlaylistMapper;

    @Override
    public List<LikedPlaylist> list() throws Exception {
        return likedPlaylistMapper.list();
    }

    @Override
    public LikedPlaylist select(Long id) throws Exception {
        return likedPlaylistMapper.select(id);
    }

    @Override
    public boolean insert(LikedPlaylist likedPlaylist) throws Exception {
        return likedPlaylistMapper.insert(likedPlaylist) > 0;
    }

    @Override
    public boolean update(LikedPlaylist likedPlaylist) throws Exception {
        return likedPlaylistMapper.update(likedPlaylist) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return likedPlaylistMapper.delete(id) > 0;
    }
}
