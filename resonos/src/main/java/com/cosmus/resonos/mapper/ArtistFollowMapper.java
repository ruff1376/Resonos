package com.cosmus.resonos.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.cosmus.resonos.domain.ArtistFollow;

@Mapper
public interface ArtistFollowMapper {
    // 전체 조회
    public List<ArtistFollow> list() throws Exception;
    // 조회
    public ArtistFollow select(String id) throws Exception;
    // 삽입
    public int insert(ArtistFollow artistFollow) throws Exception;
    // 수정
    public int update(ArtistFollow artistFollow) throws Exception;
    // 삭제
    public int delete(String id) throws Exception;
}
