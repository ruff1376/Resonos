package com.cosmus.resonos.service.admin;

import java.util.List;

import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.admin.Tag;
import com.cosmus.resonos.mapper.admin.TagMapper;

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

    @Override
    public List<Tag> searchByName(String keyword) {
        return tagMapper.searchByName(keyword);
    }

    @Override
    public long countAll() {
        return tagMapper.countAll();
    }

    @Override
    public long countByKeyword(String keyword) {
        return tagMapper.countByKeyword(keyword);
    }

    @Override
    public List<Tag> listPaging(long offset, long size) {
        return tagMapper.listPaging(offset, size);
    }

    @Override
    public List<Tag> searchByNamePaging(String keyword, long offset, long size) {
        return tagMapper.searchByNamePaging(keyword, offset, size);
    }

}
