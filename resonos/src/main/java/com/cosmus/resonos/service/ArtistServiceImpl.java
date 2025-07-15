package com.cosmus.resonos.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Artist;
import com.cosmus.resonos.domain.Pagination;
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

    @Override
    public Artist getArtistFromSpotify(String artistId) throws Exception {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'getArtistFromSpotify'");
    }

    @Override
    public Artist saveOrUpdateArtist(Artist artist) throws Exception {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'saveOrUpdateArtist'");
    }

    @Override
    public Artist selectArtistByTrackId(String id) throws Exception {
        return artistMapper.selectArtistByTrackId(id);
    }

    @Override
    public List<Artist> listPaging(int offset, int size) throws Exception {
        return artistMapper.listPaging(offset, size);
    }

    @Override
    public List<Artist> searchList(String keyword) throws Exception {
        return artistMapper.searchList(keyword);
    }

    @Override
    public List<Artist> allSearchList(Map<String, Object> paramMap) throws Exception {
        String keyword = (String) paramMap.get("keyword");
        Pagination pagination = (Pagination) paramMap.get("pagination");
        long total = artistMapper.searchCount(keyword);
        if (pagination != null) {
            pagination.setTotal(total);
        }
        Map<String, Object> queryMap = new HashMap<>();
        queryMap.put("keyword", keyword);
        queryMap.put("index", pagination.getIndex());
        queryMap.put("size", pagination.getSize());
        return artistMapper.allSearchList(queryMap);
    }
    @Override
    public long count() throws Exception {
        return artistMapper.count();
    }

    @Override
    public Artist findArtistByAlbumId(String id) throws Exception {
        return artistMapper.findArtistByAlbumId(id);
    }

    @Override
    public long searchCount(String keyword) throws Exception {
        return artistMapper.searchCount(keyword);
    }

    @Override
    public List<Artist> followingArtistsTop3(Long id) throws Exception {
        return artistMapper.followingArtistsTop3(id);
    }

    @Override
    public List<Artist> followingArtists(Long id, String keyword, int offset, int limit) throws Exception {
        return artistMapper.followingArtists(id, keyword, offset, limit);
    }

    @Override
    public int countFollowingArtists(Long id) throws Exception {
        return artistMapper.countFollowingArtists(id);
    }

}
