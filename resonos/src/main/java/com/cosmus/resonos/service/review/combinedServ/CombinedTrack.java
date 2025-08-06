package com.cosmus.resonos.service.review.combinedServ;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosmus.resonos.domain.review.Track;
import com.cosmus.resonos.service.admin.TagService;
import com.cosmus.resonos.service.review.AlbumService;
import com.cosmus.resonos.service.review.ArtistService;
import com.cosmus.resonos.service.review.MoodStatService;
import com.cosmus.resonos.service.review.ReviewLikeService;
import com.cosmus.resonos.service.review.TrackMoodVoteService;
import com.cosmus.resonos.service.review.TrackReviewService;
import com.cosmus.resonos.service.review.TrackService;
import com.cosmus.resonos.service.user.LikedTrackService;
import com.cosmus.resonos.service.user.PlaylistDetailService;
import com.cosmus.resonos.service.user.PlaylistService;

public class CombinedTrack {

    @Autowired
    private TrackService trackService;
    @Autowired
    private AlbumService albumService;
    @Autowired
    private ArtistService artistService;
    @Autowired
    private TrackReviewService trackReviewService;
    @Autowired
    private PlaylistDetailService playlistDetailService;
    @Autowired
    private ReviewLikeService reviewLikeService;
    @Autowired
    private TagService tagService;
    @Autowired
    private TrackMoodVoteService trackMoodVoteService;
    @Autowired
    private MoodStatService moodStatService;
    @Autowired
    private LikedTrackService likedTrackService;
    @Autowired
    private PlaylistService playlistService;

    // Track track = trackService.getTrackOrUpdate(id);

}
