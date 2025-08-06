package com.cosmus.resonos.service.admin;

import java.util.List;

import com.cosmus.resonos.domain.admin.Setting;

public interface SettingService {
    // 전체 조회
    public List<Setting> list() throws Exception;
    // 조회
    public Setting select(Long id) throws Exception;
    // 삽입
    public boolean insert(Setting setting) throws Exception;
    // 수정
    public boolean update(Setting setting) throws Exception;
    // 삭제
    public boolean delete(Long id) throws Exception;
    // selectByValue(value)
    public Setting selectByValue(String value) throws Exception;
    // selectByName(name)
    public Setting selectByName(String name) throws Exception;
}
