package com.cosmus.resonos.service;

import java.util.List;

import com.cosmus.resonos.domain.Report;

public interface ReportService {
    // 전체 조회
    public List<Report> list() throws Exception;
    // 조회
    public Report select(Long id) throws Exception;
    // 삽입
    public boolean insert(Report report) throws Exception;
    // 수정
    public boolean update(Report report) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
    // 어드민 통계용
    public int countAll() throws Exception;
    // 어드민 블라인드
    public int countByBlind() throws Exception;
}
