package com.cosmus.resonos.mapper;

import com.cosmus.resonos.domain.ChartElement;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Map;

@Mapper
public interface ChartElementMapper {

    ChartElement findByUserAndAlbum(@Param("userId") Long userId, @Param("albumId") String albumId);

    void insert(ChartElement element);

    void update(ChartElement element);

    Map<String, Object> getAverageScoresByAlbumId(@Param("albumId") String albumId);
}
