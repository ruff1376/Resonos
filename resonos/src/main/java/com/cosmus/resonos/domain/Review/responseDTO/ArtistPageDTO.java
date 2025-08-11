package com.cosmus.resonos.domain.review.responseDTO;

import java.util.List;

import com.cosmus.resonos.domain.admin.Tag;
import com.cosmus.resonos.domain.review.Album;
import com.cosmus.resonos.domain.review.Artist;
import com.cosmus.resonos.domain.review.MoodStat;
import com.cosmus.resonos.domain.review.RecentReview;
import com.cosmus.resonos.domain.review.Track;

import lombok.Data;

@Data
public class ArtistPageDTO {

    // 아티스트 기본 정보
    private Artist artist;

    // 팔로우 정보
    private boolean isArtistFollowed = false; // 로그인 유저의 팔로우 여부
    private Integer followCount; // 전체 팔로워 수

    // 앨범 정보
    private List<Album> albums;
    private int albumCount;

    // 트랙 정보
    private int trackCount;
    private List<Track> top7Tracks; // 인기곡 7개
    private Track track; // top7List의 첫 번째 트랙

    // 분위기 정보
    private Long userVotedMoodId; // 로그인 유저의 투표 무드 ID
    private boolean isMoodEmpty;
    private List<String> moodLabels; // 상위 6개 분위기의 이름
    private List<Integer> moodValues; // 상위 6개 분위기의 투표 수
    private List<MoodStat> moodStats; // 상위 6개 분위기



    // 리뷰 정보
    private List<RecentReview> recentReviews;

    // 태그 정보
    private List<Tag> allTags; // 모든 태그 리스트
    
}
