package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.cosmus.resonos.domain.LikedAlbum;

@Mapper
public interface LikedAlbumMapper {
    // 전체 조회
    public List<LikedAlbum> list() throws Exception;
    // 조회
    public LikedAlbum select(Long id) throws Exception;
    // 삽입
    public int insert(LikedAlbum likedAlbum) throws Exception;
    // 수정
    public int update(LikedAlbum likedAlbum) throws Exception;
    // 삭제
    public int delete(Long id) throws Exception;
}
