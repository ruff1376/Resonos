package com.cosmus.resonos.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.LikedAlbum;
import com.cosmus.resonos.mapper.LikedAlbumMapper;

@Service
public class LikedAlbumServiceImpl implements LikedAlbumService {

    @Autowired
    private LikedAlbumMapper likedAlbumMapper;

    @Override
    public List<LikedAlbum> list() throws Exception {
        return likedAlbumMapper.list();
    }

    @Override
    public LikedAlbum select(Long id) throws Exception {
        return likedAlbumMapper.select(id);
    }

    @Override
    public boolean insert(LikedAlbum likedAlbum) throws Exception {
        return likedAlbumMapper.insert(likedAlbum) > 0;
    }

    @Override
    public boolean update(LikedAlbum likedAlbum) throws Exception {
        return likedAlbumMapper.update(likedAlbum) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return likedAlbumMapper.delete(id) > 0;
    }
}
