package com.cosmus.resonos.service;

import java.util.List;
import com.cosmus.resonos.domain.ExternalApiConfig;

public interface ExternalApiConfigService {
    // 전체 조회
    public List<ExternalApiConfig> list() throws Exception;
    // 조회
    public ExternalApiConfig select(Long id) throws Exception;
    // 삽입
    public boolean insert(ExternalApiConfig config) throws Exception;
    // 수정
    public boolean update(ExternalApiConfig config) throws Exception;
    // 삭제 
    public boolean delete(Long id) throws Exception;
    // 토글로 상태 전환 
    public void toggleEnabled(Long id) throws Exception;
}
