package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.cosmus.resonos.domain.ChartElement;

@Mapper
public interface ChartElementMapper {
    // 전체 조회
    public List<ChartElement> list() throws Exception;
    // 조회
    public ChartElement select(Long id) throws Exception;
    // 삽입
    public int insert(ChartElement chartElement) throws Exception;
    // 수정
    public int update(ChartElement chartElement) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
}
