package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.ArtistFollow;

public interface ArtistFollowService {
    // 전체 조회
    public List<ArtistFollow> list() throws Exception;
    // 조회
    public ArtistFollow select(String id) throws Exception;
    // 삽입
    public boolean insert(ArtistFollow artistFollow) throws Exception;
    // 수정 
    public boolean update(ArtistFollow artistFollow) throws Exception;
    // 삭제
    public boolean delete(String id) throws Exception;
}
