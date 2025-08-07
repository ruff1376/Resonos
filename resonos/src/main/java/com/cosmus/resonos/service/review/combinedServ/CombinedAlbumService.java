package com.cosmus.resonos.service.review.combinedServ;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.service.review.AlbumReviewService;
import com.cosmus.resonos.service.review.AlbumService;
import com.cosmus.resonos.service.review.ArtistService;
import com.cosmus.resonos.service.review.ChartElementService;
import com.cosmus.resonos.service.review.ReviewLikeService;
import com.cosmus.resonos.service.review.TrackService;
import com.cosmus.resonos.service.user.LikedAlbumService;
import com.cosmus.resonos.service.user.PlaylistService;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class CombinedAlbumService {

    private final TrackService trackService;
    private final AlbumService albumService;
    private final AlbumReviewService albumReviewService;
    private final ArtistService artistService;
    private final ReviewLikeService reviewLikeService;
    private final LikedAlbumService likedAlbumService;
    private final ChartElementService chartElementService;
    private final PlaylistService playlistService;

    
    
}
