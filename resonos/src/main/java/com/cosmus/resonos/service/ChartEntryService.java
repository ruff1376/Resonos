package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.ChartEntry;

public interface ChartEntryService {
    // 전체 조회
    public List<ChartEntry> list() throws Exception;
    // 조회
    public ChartEntry select(Long id) throws Exception;
    // 삽입
    public boolean insert(ChartEntry entry) throws Exception;
    // 수정
    public boolean update(ChartEntry entry) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
}
