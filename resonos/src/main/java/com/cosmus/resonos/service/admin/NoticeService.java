package com.cosmus.resonos.service.admin;

import java.util.List;

import com.cosmus.resonos.domain.admin.Notice;

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
    // 활성화 된 공지사항 목록
    public List<Notice> listActive() throws Exception;
}
