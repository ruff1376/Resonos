package com.cosmus.resonos.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cosmus.resonos.domain.LikedAlbum;
import com.cosmus.resonos.mapper.LikedAlbumMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class LikedAlbumServiceImpl implements LikedAlbumService {

    private final LikedAlbumMapper likedAlbumMapper;

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
        likedAlbum.setCreatedAt(new Date());
        return likedAlbumMapper.insert(likedAlbum) > 0;
    }

    @Override
    public boolean update(LikedAlbum likedAlbum) throws Exception {
        return likedAlbumMapper.update(likedAlbum) > 0;
    }

    @Override
    public boolean deleteById(Long id) throws Exception {
        return likedAlbumMapper.deleteById(id) > 0;
    }

    @Override
    public boolean toggleLike(Long userId, String albumId) throws Exception {
        LikedAlbum existing = likedAlbumMapper.findByUserAndAlbum(userId, albumId);

        if (existing != null) {
            // 좋아요가 이미 있으면 삭제
            likedAlbumMapper.deleteById(existing.getId());
            return false;
        } else {
            // 없으면 새로 생성
            LikedAlbum likedAlbum = new LikedAlbum();
            likedAlbum.setUserId(userId);
            likedAlbum.setAlbumId(albumId);
            likedAlbum.setCreatedAt(new Date());
            return likedAlbumMapper.insert(likedAlbum) > 0;
        }
    }

    @Override
    public boolean isLikedByUser(Long userId, String albumId) {
        return likedAlbumMapper.findByUserAndAlbum(userId, albumId) != null;
    }

    @Override
    public int getAlbumLikeCount(String albumId) {
        return likedAlbumMapper.countByAlbumId(albumId);
    }
}
