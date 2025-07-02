package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.BoardPost;

public interface BoardPostService {
    // 전체 조회
    public List<BoardPost> list() throws Exception;
    // 조회
    public BoardPost select(Long id) throws Exception;
    // 삽입
    public boolean insert(BoardPost post) throws Exception;
    // 수정
    public boolean update(BoardPost post) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
    // 커뮤니티
    public List<BoardPost> findByCommunity(Long communityId) throws Exception;
    // 어드민 통계용
    public int countAll() throws Exception;
}
