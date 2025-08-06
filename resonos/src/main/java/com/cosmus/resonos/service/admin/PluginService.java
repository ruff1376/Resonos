package com.cosmus.resonos.service.admin;

import java.util.List;

import com.cosmus.resonos.domain.admin.Plugin;

public interface PluginService {
    // 전체 조회
    public List<Plugin> list() throws Exception;
    // 조회
    public Plugin select(Long id) throws Exception;
    // 삽입
    public boolean insert(Plugin plugin) throws Exception;
    // 수정
    public boolean update(Plugin plugin) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
    // 토글로 상태 전환
    public void toggleEnabled(Long id) throws Exception;

}
