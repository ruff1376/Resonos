package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.cosmus.resonos.domain.PlaylistDetail;

@Mapper
public interface PlaylistDetailMapper {
    // 전체 조회
    public List<PlaylistDetail> list() throws Exception;
    // 조회
    public PlaylistDetail select(Long id) throws Exception;
    // 삽입
    public int insert(PlaylistDetail detail) throws Exception;
    // 수정
    public int update(PlaylistDetail detail) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
}
