package com.cosmus.resonos.mapper.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.user.Notice;

@Mapper
public interface NoticeMapper {
    // 목록
    public List<Notice> list() throws Exception;
    // 조획
    public Notice select(Long id) throws Exception;
    // 삽입
    public int insert(Notice notice) throws Exception;
    // 수정
    public int update(Notice notice) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    // 활성화 된 공지사항 목록
    public List<Notice> listActive() throws Exception;

}