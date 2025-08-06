package com.cosmus.resonos.mapper.community;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.community.BoardPost;

@Mapper
public interface BoardPostMapper {
    // 전체 조회
    public List<BoardPost> list() throws Exception;
    // 조회
    public BoardPost select(Long id) throws Exception;
    // 삽입
    public int insert(BoardPost post) throws Exception;
    // 수정
    public int update(BoardPost post) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    // 커뮤니티
    public List<BoardPost> findByCommunity(Long communityId) throws Exception;
    // 어드민 통계용
    public int countAll() throws Exception;
    // 게시글 구하기
    public int countByUserId(Long userId);
}
