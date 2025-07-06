package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.cosmus.resonos.domain.Playlist;

@Mapper
public interface PlaylistMapper {
    // 전체 조회
    public List<Playlist> list() throws Exception;
    // 조회
    public Playlist select(Long id) throws Exception;
    // 삽입
    public int insert(Playlist playlist) throws Exception;
    // 수정
    public int update(Playlist playlist) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
    // 특정 유저의 플레이리스트 조회
    public List<Playlist> usersPlaylist(Long userId) throws Exception;
}
