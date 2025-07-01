package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Album;
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
}
