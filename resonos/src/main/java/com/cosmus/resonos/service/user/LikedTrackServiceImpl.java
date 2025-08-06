package com.cosmus.resonos.service.user;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.review.LikedTrack;
import com.cosmus.resonos.mapper.review.LikedTrackMapper;

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
    public boolean deleteById(Long id) throws Exception {
        return likedTrackMapper.deleteById(id) > 0;
    }
    @Override
    public boolean toggleLike(Long userId, String trackId) throws Exception {
        LikedTrack existing = likedTrackMapper.findByUserAndTrack(userId, trackId);
        if (existing != null) {
            likedTrackMapper.deleteById(existing.getId());
            return false; // 좋아요 취소
        } else {
            LikedTrack newLike = new LikedTrack();
            newLike.setCreatedAt(new Date());
            newLike.setUserId(userId);
            newLike.setTrackId(trackId);
            likedTrackMapper.insert(newLike);
            return true; // 좋아요 추가
        }
    }

    @Override
    public int getTrackLikeCount(String trackId) {
        return likedTrackMapper.countByTrackId(trackId);
    }

    @Override
    public boolean isLikedByUser(Long userId, String trackId) {
        return likedTrackMapper.findByUserAndTrack(userId, trackId) != null;
    }

}
