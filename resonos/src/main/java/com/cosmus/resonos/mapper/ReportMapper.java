package com.cosmus.resonos.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.Report;

@Mapper
public interface ReportMapper {
    // 전체 조회
    public List<Report> list() throws Exception;
    // 조회
    public Report select(Long id) throws Exception;
    // 삽입
    public int insert(Report report) throws Exception;
    // 수정
    public int update(Report report) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    // 어드민 통계용 
    public int countAll() throws Exception;
    // 어드민 블라인드
    public int countByBlind() throws Exception;
}
