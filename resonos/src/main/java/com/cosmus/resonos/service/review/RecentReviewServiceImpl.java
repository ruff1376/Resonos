package com.cosmus.resonos.service.review;

import com.cosmus.resonos.domain.review.RecentReview;
import com.cosmus.resonos.mapper.review.RecentReviewMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RecentReviewServiceImpl implements RecentReviewService {

    private final RecentReviewMapper recentReviewMapper;

    @Autowired
    public RecentReviewServiceImpl(RecentReviewMapper recentReviewMapper) {
        this.recentReviewMapper = recentReviewMapper;
    }

    @Override
    public List<RecentReview> getRecentReviewsByArtistId(String artistId) {
        return recentReviewMapper.findRecentReviewsByArtistId(artistId);
    }
}
