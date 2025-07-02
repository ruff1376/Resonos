package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.cosmus.resonos.domain.Comment;

@Mapper
public interface CommentMapper {
    // 전체 조회
    public List<Comment> list() throws Exception;
    // 조회
    public Comment select(Long id) throws Exception;
    // 삽입
    public int insert(Comment comment) throws Exception;
    // 수정
    public int update(Comment comment) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    // 대댓글
    public List<Comment> findByTarget(String type, Long targetId) throws Exception;
}
