package com.cosmus.resonos.service;

import java.util.List;

import com.cosmus.resonos.domain.Notice;

public interface NoticeService {
    // 목록
    public List<Notice> list() throws Exception;
    // 선택
    public Notice select(Long id) throws Exception;
    // 삽입
    public boolean insert(Notice notice) throws Exception;
    // 수정
    public boolean update(Notice notice) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
}
