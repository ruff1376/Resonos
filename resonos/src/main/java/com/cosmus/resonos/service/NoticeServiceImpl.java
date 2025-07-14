package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Notice;
import com.cosmus.resonos.mapper.NoticeMapper;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    private NoticeMapper noticeMapper;
    
    @Override
    public List<Notice> list() throws Exception {
        return noticeMapper.list();
    }

    @Override
    public Notice select(Long id) throws Exception {
        return noticeMapper.select(id);
    }

    @Override
    public boolean insert(Notice notice) throws Exception {
        return noticeMapper.insert(notice) > 0;
    }

    @Override
    public boolean update(Notice notice) throws Exception {
        return noticeMapper.update(notice) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return noticeMapper.delete(id) > 0;
    }

    @Override
    public List<Notice> listActive() throws Exception {
        return noticeMapper.listActive();
    }

}
