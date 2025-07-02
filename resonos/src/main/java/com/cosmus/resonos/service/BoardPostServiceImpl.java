package com.cosmus.resonos.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.cosmus.resonos.domain.BoardPost;
import com.cosmus.resonos.mapper.BoardPostMapper;

@Service
public class BoardPostServiceImpl implements BoardPostService {

    private final BoardPostMapper boardPostMapper;

    public BoardPostServiceImpl(BoardPostMapper boardPostMapper) {
        this.boardPostMapper = boardPostMapper;
    }

    @Override
    public List<BoardPost> list() throws Exception {
        return boardPostMapper.list();
    }

    @Override
    public BoardPost select(Long id) throws Exception {
        return boardPostMapper.select(id);
    }

    @Override
    public boolean insert(BoardPost post) throws Exception {
        return boardPostMapper.insert(post) > 0;
    }

    @Override
    public boolean update(BoardPost post) throws Exception {
        return boardPostMapper.update(post) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return boardPostMapper.delete(id) > 0;
    }

    @Override
    public List<BoardPost> findByCommunity(Long communityId) throws Exception {
        return boardPostMapper.findByCommunity(communityId);
    }
}
