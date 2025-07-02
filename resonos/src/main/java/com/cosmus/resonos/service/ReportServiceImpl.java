package com.cosmus.resonos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Report;
import com.cosmus.resonos.mapper.ReportMapper;

@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    private ReportMapper reportMapper;

    @Override
    public List<Report> list() throws Exception {
        return reportMapper.list();
    }

    @Override
    public Report select(Long id) throws Exception {
        return reportMapper.select(id);
    }

    @Override
    public boolean insert(Report report) throws Exception {
        return reportMapper.insert(report) > 0;
    }

    @Override
    public boolean update(Report report) throws Exception {
        return reportMapper.update(report) > 0;
    }

    @Override
    public boolean delete(Long id) throws Exception {
        return reportMapper.delete(id) > 0;
    }
    @Override
    public int countAll() throws Exception {
    return reportMapper.countAll();
    }

    @Override
    public int countByBlind() throws Exception {
        return reportMapper.countByBlind();
    }
    

}
