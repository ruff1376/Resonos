package com.cosmus.resonos.service;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Artist.ArtistFollow;
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
    public boolean delete(Long id) throws Exception {
        return artistFollowMapper.delete(id) > 0;
    }

    @Override
    public boolean toggleLike(Long userId, String artistId) throws Exception {
        ArtistFollow exsisting = artistFollowMapper.findByUserAndArtist(userId, artistId);
        if (exsisting != null) {
            artistFollowMapper.delete(exsisting.getId());
            return false;
        } else {
            ArtistFollow newFollow = new ArtistFollow();
            newFollow.setUserId(userId);
            newFollow.setArtistId(artistId);
            newFollow.setCreatedAt(new Date());
            artistFollowMapper.insert(newFollow);
            return true;
        }
    }

    @Override
    public boolean isLikedByUser(Long userId, String artistId) throws Exception {
        return artistFollowMapper.findByUserAndArtist(userId, artistId) != null ;
    }

    @Override
    public int getArtistFollowCount(String artistId) {
        return artistFollowMapper.countByArtistId(artistId);
    }
}
