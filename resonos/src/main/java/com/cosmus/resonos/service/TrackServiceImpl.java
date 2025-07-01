package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Track;
import com.cosmus.resonos.mapper.TrackMapper;

@Service
public class TrackServiceImpl implements TrackService {

    private final TrackMapper trackMapper;

    // 생성자 주입
    public TrackServiceImpl(TrackMapper trackMapper) {
        this.trackMapper = trackMapper;
    }

    // 트랙 목록 조회
    @Override
    public List<Track> list() throws Exception {
        return trackMapper.list();
    }

    // 트랙 단건 조회
    @Override
    public Track select(Integer no) throws Exception {
        return trackMapper.select(no);
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
}
