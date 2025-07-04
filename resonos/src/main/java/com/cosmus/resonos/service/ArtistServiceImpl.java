package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.mapper.ArtistMapper;

@Service
public class ArtistServiceImpl implements ArtistService {

    @Autowired
    private ArtistMapper artistMapper;

    // 아티스트 목록 조회
    @Override
    public List<Artist> list() throws Exception {
        return artistMapper.list();
    }

    // 아티스트 단건 조회
    @Override
    public Artist selectById(String id) throws Exception {
        return artistMapper.selectById(id);
    }

    // 아티스트 등록
    @Override
    public boolean insert(Artist artist) throws Exception {
        return artistMapper.insert(artist) > 0;
    }

    // 아티스트 수정
    @Override
    public boolean update(Artist artist) throws Exception {
        return artistMapper.update(artist) > 0;
    }

    // 아티스트 삭제
    @Override
    public boolean delete(String id) throws Exception {
        return artistMapper.delete(id) > 0;
    }

    // 아티스트 존재 여부 확인
    @Override
    public boolean exists(String id) throws Exception {
        return artistMapper.exists(id) > 0;
    }

    @Override
    public String selectTopMvUrlByArtist(String id) throws Exception {
        return artistMapper.selectTopMvUrlByArtist(id);
    }
}
