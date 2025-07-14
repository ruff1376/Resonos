package com.cosmus.resonos.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.cosmus.resonos.domain.Album;
import com.cosmus.resonos.domain.AlbumReview;
import com.cosmus.resonos.domain.AlbumScore;
import com.cosmus.resonos.domain.ReviewReport;

@Mapper
public interface AlbumReviewMapper {

    AlbumReview findById(Long id);

    void insert(AlbumReview review);

    List<AlbumReview> findByAlbumId(String albumId);

    List<AlbumReview> reviewWithReviewerByAlbumId(String albumId);

    List<AlbumReview> selectPagedReviewsWithReviewer(@Param("albumId") String albumId,
                                                     @Param("size") int size,
                                                     @Param("offset") int offset);

    List<AlbumReview> reviewWithReviewerByUserId(Long loginUserId);

    void updateBlindStatus(@Param("id") Long id, @Param("blinded") boolean blinded);

    void incrementLikes(Long id);

    void incrementDislikes(Long id);

    AlbumReview getLastestReview(@Param("albumId")String albumId, @Param("userId") Long userId);

    AlbumScore findScoreByAlbumId(String albumId);

    void update(AlbumReview review);

    void delete(Long id);

    boolean existsByUserAndAlbum(@Param("userId") Long userId, @Param("albumId") String albumId);

    long countByAlbumId(String albumId);

    public long countAll() throws Exception;
    public     List<AlbumReview> findAllReviewsWithReviewer();

}
