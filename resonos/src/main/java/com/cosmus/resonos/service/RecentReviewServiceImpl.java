package com.cosmus.resonos.service;

import com.cosmus.resonos.domain.RecentReview;
import com.cosmus.resonos.mapper.RecentReviewMapper;
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
