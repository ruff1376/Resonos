package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.Comment;

public interface CommentService {
    // 전체 조회
    public List<Comment> list() throws Exception;
    // 조회
    public Comment select(Long id) throws Exception;
    // 삽입
    public boolean insert(Comment comment) throws Exception;
    // 수정
    public boolean update(Comment comment) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
    // 대댓글
    public List<Comment> findByTarget(String type, Long targetId) throws Exception;
}
