package com.cosmus.resonos.mapper.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.Pagination;
import com.cosmus.resonos.domain.admin.Report;

@Mapper
public interface ReportMapper {
    public List<Report> findByReporterId(Long reporterId)throws Exception;
    public List<Report> findByTargetId(Long targetId)throws Exception;
    public List<Report> findByTargetTypeAndTargetId(String targetType, Long targetId)throws Exception;
    public List<Report> findAll()throws Exception;
    public void updateStatus(@Param("id") Long id,@Param("status") String status,@Param("processedBy") Long processedBy,@Param("processMemo") String processMemo) throws Exception;
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
    // report 페이징 countByStatus, findByStatusPaging, findAllPaging
    public long countByStatus(String status) throws Exception;
    public List<Report> findByStatusPaging(@Param("status") String status,@Param("pagination") Pagination pagination) throws Exception;
    public List<Report> findAllPaging(Pagination pagination) throws Exception;



}
