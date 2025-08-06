package com.cosmus.resonos.mapper.review;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.Album.LikedAlbum;


@Mapper
public interface LikedAlbumMapper {
    List<LikedAlbum> list() throws Exception;

    LikedAlbum select(Long id) throws Exception;

    int insert(LikedAlbum likedAlbum) throws Exception;

    int update(LikedAlbum likedAlbum) throws Exception;

    int deleteById(Long id) throws Exception;

    int countByAlbumId(@Param("albumId") String albumId);

    LikedAlbum findByUserAndAlbum(@Param("userId") Long userId, @Param("albumId") String albumId);
}