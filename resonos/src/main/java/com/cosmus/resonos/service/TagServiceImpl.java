package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Tag;
import com.cosmus.resonos.mapper.TagMapper;

@Service
public class TagServiceImpl implements TagService {

    private final TagMapper tagMapper;

    public TagServiceImpl(TagMapper tagMapper) {
        this.tagMapper = tagMapper;
    }

    @Override
    public List<Tag> list() throws Exception {
        return tagMapper.list();
    }

    @Override
    public Tag select(Long id) throws Exception {
        return tagMapper.select(id);
    }

    @Override
    public boolean insert(Tag tag) throws Exception {
        return tagMapper.insert(tag) > 0;
    }

    @Override
    public boolean update(Tag tag) throws Exception {
        return tagMapper.update(tag) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return tagMapper.delete(id) > 0;
    }
}
