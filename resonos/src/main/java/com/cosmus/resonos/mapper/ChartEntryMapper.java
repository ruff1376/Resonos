package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.cosmus.resonos.domain.ChartEntry;

@Mapper
public interface ChartEntryMapper {
    // 전체 조회
    public List<ChartEntry> list() throws Exception;
    // 조회
    public ChartEntry select(Long id) throws Exception;
    // 삽입
    public int insert(ChartEntry entry) throws Exception;
    // 수정
    public int update(ChartEntry entry) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
}
