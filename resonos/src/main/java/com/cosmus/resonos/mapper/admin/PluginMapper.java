package com.cosmus.resonos.mapper.admin;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;

import com.cosmus.resonos.domain.admin.Plugin;

@Mapper
public interface PluginMapper {
    // 전체 조회
    public List<Plugin> list() throws Exception;
    // 조회
    public Plugin select(Long id) throws Exception;
    // 삽입
    public int insert(Plugin plugin) throws Exception;
    // 수정
    public int update(Plugin plugin) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;

}
