package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.mapper.TrackMapper;

@Service
public class TrackServiceImpl implements TrackService {

    @Autowired
    private TrackMapper trackMapper;

    // 트랙 목록 조회
    @Override
    public List<Track> list() throws Exception {
        return trackMapper.list();
    }

    // 메인 화면 최신 트랙 목록 조회
    @Override
    public List<Track> mainNewList() throws Exception {
        return trackMapper.mainNewList();
    }

    // 트랙 단건 조회
    @Override
    public Track selectById(String id) throws Exception {
        return trackMapper.selectById(id);
    }

    // 트랙 등록
    @Override
    public boolean insert(Track track) throws Exception {
        return trackMapper.insert(track) > 0;
    }

    // 트랙 수정
    @Override
    public boolean update(Track track) throws Exception {
        return trackMapper.update(track) > 0;
    }

    // 트랙 삭제
    @Override
    public boolean delete(String id) throws Exception {
        return trackMapper.delete(id) > 0;
    }

    // 트랙 존재 여부 확인
    @Override
    public boolean exists(String id) throws Exception {
        return trackMapper.exists(id) > 0;
    }

    @Override
    public List<Track> selectTop7TracksByArtist(String id) throws Exception {
        return trackMapper.selectTop7TracksByArtist(id);
    }

    @Override
    public int countTracksByArtist(String id) throws Exception {
        return trackMapper.countTracksByArtist(id);
    }
}
