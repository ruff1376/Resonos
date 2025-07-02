package com.cosmus.resonos.service;

import java.util.List;

import com.cosmus.resonos.domain.Tag;

public interface TagService {
    // 전체 조회
    public List<Tag> list() throws Exception;
    // 조회
    public Tag select(Long id) throws Exception;
    // 삽입 
    public boolean insert(Tag tag) throws Exception;
    // 수정
    public boolean update(Tag tag) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
}
