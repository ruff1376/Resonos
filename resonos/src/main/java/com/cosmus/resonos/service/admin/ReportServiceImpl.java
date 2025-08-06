package com.cosmus.resonos.service.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.community.Report;
import com.cosmus.resonos.mapper.admin.ReportMapper;


@Service
public class ReportServiceImpl implements ReportService {

    @Override
    public List<Report> findByReporterId(Long reporterId) throws Exception{
        return reportMapper.findByReporterId(reporterId);
    }

    @Override
    public List<Report> findByTargetId(Long targetId) throws Exception{
        return reportMapper.findByTargetId(targetId);
    }

    @Override
    public List<Report> findByTargetTypeAndTargetId(String targetType, Long targetId) throws Exception{
        return reportMapper.findByTargetTypeAndTargetId(targetType, targetId);
    }

    @Override
    public List<Report> findAll() throws Exception{
        return reportMapper.findAll();
    }

    @Override
    public void updateStatus(Long id, String status, Long processedBy, String processMemo) throws Exception{
        reportMapper.updateStatus(id, status, processedBy, processMemo);
    }

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

    @Override
    public long countByStatus(String status) throws Exception {
        return reportMapper.countByStatus(status);
    }

    @Override
    public List<Report> findByStatusPaging(String status, Pagination pagination) throws Exception {
        return reportMapper.findByStatusPaging(status, pagination);
    }

    @Override
    public List<Report> findAllPaging(Pagination pagination) throws Exception {
        return reportMapper.findAllPaging(pagination);
    }

}
