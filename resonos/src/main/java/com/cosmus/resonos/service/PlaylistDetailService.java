package com.cosmus.resonos.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.PlaylistDetail;
import com.cosmus.resonos.domain.Track;

public interface PlaylistDetailService {
    // 전체 조회
    public List<PlaylistDetail> list() throws Exception;
    // 조회
    public PlaylistDetail select(Long id) throws Exception;
    // 삽입
    public boolean insert(List<PlaylistDetail> playlistDetail) throws Exception;
    // 수정
    public boolean update(PlaylistDetail detail) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
}
