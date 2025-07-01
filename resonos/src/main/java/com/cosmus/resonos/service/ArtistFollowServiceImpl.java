package com.cosmus.resonos.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.ArtistFollow;
import com.cosmus.resonos.mapper.ArtistFollowMapper;

@Service
public class ArtistFollowServiceImpl implements ArtistFollowService {

    @Autowired
    private ArtistFollowMapper artistFollowMapper;

    @Override
    public List<ArtistFollow> list() throws Exception {
        return artistFollowMapper.list();
    }

    @Override
    public ArtistFollow select(String id) throws Exception {
        return artistFollowMapper.select(id);
    }

    @Override
    public boolean insert(ArtistFollow artistFollow) throws Exception {
        return artistFollowMapper.insert(artistFollow) > 0;
    }

    @Override
    public boolean update(ArtistFollow artistFollow) throws Exception {
        return artistFollowMapper.update(artistFollow) > 0;
    }

    @Override
    public boolean delete(String id) throws Exception {
        return artistFollowMapper.delete(id) > 0;
    }
}
