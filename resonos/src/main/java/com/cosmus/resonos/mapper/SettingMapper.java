package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.cosmus.resonos.domain.Setting;

@Mapper
public interface SettingMapper {
    // 전체 조회
    public List<Setting> list() throws Exception;
    // 조회
    public Setting select(Long id) throws Exception;
    // 삽입
    public int insert(Setting setting) throws Exception;
    // 수정
    public int update(Setting setting) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    //selectByValue(value)
    public Setting selectByValue(String value) throws Exception;
    // selectByName(name)
    public Setting selectByName(String name) throws Exception;
}
