package com.cosmus.resonos.domain.review.responseDTO;

import java.util.List;
import java.util.Map;

import com.cosmus.resonos.domain.admin.Tag;
import com.cosmus.resonos.domain.review.Album;
import com.cosmus.resonos.domain.review.AlbumReview;
import com.cosmus.resonos.domain.review.AlbumScore;
import com.cosmus.resonos.domain.review.Artist;
import com.cosmus.resonos.domain.review.ChartElement;
import com.cosmus.resonos.domain.review.MoodStat;
import com.cosmus.resonos.domain.review.Track;
import com.cosmus.resonos.domain.user.Playlist;

import lombok.Data;

@Data
public class AlbumPageDTO {

    // 앨범 상세 정보
    private Album album;
    // 앨범의 아티스트
    private Artist artist;
    // 앨범의 트랙 목록
    private List<Track> tracks;
    // 앨범의 상위 5개 트랙
    private List<Track> top5List;
    // 앨범의 상위 트랙
    private Track topTrack;
    
    // 앨범에 달린 리뷰 목록
    private List<AlbumReview> reviews;
    // 앨범의 평점 정보
    private AlbumScore score;
    // 앨범 좋아요 수
    private int albumLikeCount;
    // 앨범 좋아요 여부
    private boolean isAlbumLikedByUser = false; // 비로그인시 false
    // 앨범의 트랙이 포함된 플레이리스트의 여부
    private boolean emptyPlayList = true;
    // 앨범의 트랙이 포함된 플레이리스트
    private List<Playlist> playLists;
    // 리뷰 더보기 여부
    private boolean hasNext;

    // 앨범 6요소 null 여부
    private boolean isArgEmpty = true;
    // 앨범의 6요소
    private Map<String, Integer> argValues;
    // 유저가 투표한 6요소
    private ChartElement userVote;



    // 전체 태그 목록
    private List<Tag> tags;

    // 유저 관련 항목
    private boolean isAdmin;

    // 리뷰 타입
    private final String reviewType = "ALBUM";

}
