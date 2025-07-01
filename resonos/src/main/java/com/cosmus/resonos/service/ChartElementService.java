package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.ChartElement;

public interface ChartElementService {
    // 전체 조회
    public List<ChartElement> list() throws Exception;
    // 조회
    public ChartElement select(Long id) throws Exception;
    // 삽입
    public boolean insert(ChartElement chartElement) throws Exception;
    // 수정
    public boolean update(ChartElement chartElement) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
}
