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

    @Override
    public List<Artist> list() throws Exception {
        return artistMapper.list();
    }

    @Override
    public Artist select(Integer no) throws Exception {
        return artistMapper.select(no);
    }
    
}
