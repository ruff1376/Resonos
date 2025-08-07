package com.cosmus.resonos.domain.review.responseDTO;

import java.util.List;

import com.cosmus.resonos.domain.admin.Tag;
import com.cosmus.resonos.domain.review.Album;
import com.cosmus.resonos.domain.review.Artist;
import com.cosmus.resonos.domain.review.MoodStat;
import com.cosmus.resonos.domain.review.Track;
import com.cosmus.resonos.domain.review.TrackReview;
import com.cosmus.resonos.domain.review.TrackScore;
import com.cosmus.resonos.domain.user.Playlist;

import lombok.Data;

@Data
public class TrackPageDTO {
    // 트랙 상세 정보
    private Track track;
    
    // 해당 트랙의 앨범
    private Album album;
    // 동일 앨범 내 인기 트랙 5개
    private List<Track> top5List;
    // 트랙의 해당 아티스트
    private Artist artist;
    // 트랙의 평점 정보
    private TrackScore score;

    // 트랙에 달린 리뷰 목록
    private List<TrackReview> reviews;
    // 리뷰 더보기 여부
    private boolean hasNext;

    // 로그인 유저의 투표 무드 ID
    private Long userVotedMoodId;
    // 상위 6개 분위기
    private List<MoodStat> moodStats;
    // 분위기 이름 목록 (상위 6개)
    private List<String> moodLabels;
    // 분위기 투표 수 (상위 6개)
    private List<Integer> moodValues;
    // 분위기 통계 유무
    private boolean isMoodEmpty;

    // 트랙 좋아요 수
    private int trackLikeCount;

    // 트랙이 포함된 재생목록 유무
    private boolean emptyPlayList;
    // 트랙이 포함된 공개 재생목록들
    private List<Playlist> playLists;

    // 전체 태그 목록
    private List<Tag> tags;

    // 유저 관련 항목
    private boolean isAdmin;
    // 유저의 트랙 좋아요 유무
    private boolean isTrackLikedByUser;
    // 유저 플레이리스트
    private List<Playlist> userPlaylist;

    // 리뷰 타입
    private final String reviewType = "TRACK";

    

}
