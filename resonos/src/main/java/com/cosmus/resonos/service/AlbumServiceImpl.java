package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.mapper.AlbumMapper;

@Service
public class AlbumServiceImpl implements AlbumService {

    @Autowired
    private AlbumMapper albumMapper;

    // 앨범 목록 조회
    @Override
    public List<Album> list() throws Exception {
        return albumMapper.list();
    }

    // 메인 회면 최신 앨범 목록
    @Override
    public List<Album> mainNewList() throws Exception {
        return albumMapper.mainNewList();
    }

    // 최신 앨범 목록 조회
    @Override
    public List<Album> newList(Pagination pagination) throws Exception {
        long total = albumMapper.count();
        pagination.setTotal(total);
        return albumMapper.newList(pagination);
    }

    // 앨범 단건 조회
    @Override
    public Album select(Integer no) throws Exception {
        return albumMapper.select(no);
    }

    // 앨범 등록
    @Override
    public boolean insert(Album album) throws Exception {
        return albumMapper.insert(album) > 0;
    }

    // 앨범 수정
    @Override
    public boolean update(Album album) throws Exception {
        return albumMapper.update(album) > 0;
    }

    // 앨범 삭제
    @Override
    public boolean delete(String id) throws Exception {
        return albumMapper.delete(id) > 0;
    }

    // 앨범 존재 여부 확인
    @Override
    public boolean exists(String id) throws Exception {
        return albumMapper.exists(id) > 0;
    }

    @Override
    public List<Album> findAlbumsByArtistId(String id) throws Exception {
        return albumMapper.findAlbumsByArtistId(id);
    }

    @Override
    public int countAlbumsByArtist(String id) throws Exception {
        return albumMapper.countAlbumsByArtist(id);
    }

    
}
