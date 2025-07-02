package com.cosmus.resonos.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.Comment;
import com.cosmus.resonos.mapper.CommentMapper;

@Service
public class CommentServiceImpl implements CommentService {

    private final CommentMapper commentMapper;

    public CommentServiceImpl(CommentMapper commentMapper) {
        this.commentMapper = commentMapper;
    }

    @Override
    public List<Comment> list() throws Exception {
        return commentMapper.list();
    }

    @Override
    public Comment select(Long id) throws Exception {
        return commentMapper.select(id);
    }

    @Override
    public boolean insert(Comment comment) throws Exception {
        return commentMapper.insert(comment) > 0;
    }

    @Override
    public boolean update(Comment comment) throws Exception {
        return commentMapper.update(comment) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return commentMapper.delete(id) > 0;
    }

    @Override
    public List<Comment> findByTarget(String type, Long targetId) throws Exception {
        return commentMapper.findByTarget(type, targetId);
    }
}
