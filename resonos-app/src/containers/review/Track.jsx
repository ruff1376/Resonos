import React, { useEffect, useState } from 'react'
import { useSearchParams } from 'react-router-dom'
import * as api from "../../apis/review"
import styles from './Track.module.css'
import TrackInfo from '../../components/review/track/TrackInfo';
import MvAndStreaming from '../../components/review/common/MvAndStreaming';
import Review from '../../components/review/common/Review';
import MoodStatus from '../../components/review/common/MoodStatus';
import TextPressure from '../../assets/TextPressure';

const Track = () => {

  const [searchParams] = useSearchParams();
  const id = searchParams.get('id');

  // DTO의 모든 필드를 개별 useState로 분리
  const [track, setTrack] = useState({});
  const [album, setAlbum] = useState({});
  const [top5List, setTop5List] = useState([]);
  const [artist, setArtist] = useState({});
  const [score, setScore] = useState(null);
  const [reviews, setReviews] = useState([]);
  const [hasNext, setHasNext] = useState(false);
  const [userVotedMoodId, setUserVotedMoodId] = useState(null);
  const [moodStats, setMoodStats] = useState([]);
  const [moodLabels, setMoodLabels] = useState([]);
  const [moodValues, setMoodValues] = useState([]);
  const [isMoodEmpty, setIsMoodEmpty] = useState(true);
  const [trackLikeCount, setTrackLikeCount] = useState(0);
  const [emptyPlayList, setEmptyPlayList] = useState(true);
  const [playLists, setPlayLists] = useState([]);
  const [tags, setTags] = useState([]);
  const [isAdmin, setIsAdmin] = useState(false);
  const [isTrackLikedByUser, setIsTrackLikedByUser] = useState(false);
  const [userPlaylist, setUserPlaylist] = useState([]);
  const [userId, setUserId] = useState(null);
  const [reviewType, setReviewType] = useState("");
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    const fetchTrackData = async () => {
      setLoading(true);
      try {
        const response = await api.getTrackPage(id);
        console.log(response.data);
        const data = response.data;

        // 가져온 데이터를 각각의 상태에 설정합니다.
        setTrack(data.track);
        setAlbum(data.album);
        setTop5List(data.top5List);
        setArtist(data.artist);
        setScore(data.score);
        setReviews(data.reviews);
        setHasNext(data.hasNext);
        setUserVotedMoodId(data.userVotedMoodId);
        setMoodStats(data.moodStats);
        setMoodLabels(data.moodLabels);
        setMoodValues(data.moodValues);
        setIsMoodEmpty(data.isMoodEmpty);
        setTrackLikeCount(data.trackLikeCount);
        setEmptyPlayList(data.emptyPlayList);
        setPlayLists(data.playLists);
        setTags(data.tags);
        setIsAdmin(data.isAdmin);
        setIsTrackLikedByUser(data.isTrackLikedByUser);
        setUserPlaylist(data.userPlaylist);
        setUserId(data.userId);
        setReviewType(data.reviewType);
        setLoading(false);

      } catch (err) {
        console.error(err)
      }
    };
    fetchTrackData();
  }, [id]);

  if (loading) {
    return (
      <div style={{ position: 'relative', height: '300px' }}>
        <TextPressure
          text="LOADING...!"
          flex={true}
          alpha={false}
          stroke={false}
          width={true}
          weight={true}
          italic={true}
          textColor="#ffffff"
          strokeColor="#ff0000"
          minFontSize={36}
        />
      </div>
    )
  }

  return (
    <div className={styles.taWrapper}>
      <TrackInfo styles={styles} track={track} album={album} artist={artist} score={score}
        userId={userId} isTrackLikedByUser={isTrackLikedByUser} trackLikeCount={trackLikeCount} />
      <MvAndStreaming styles={styles} tracks={null} track={track} />
      <Review styles={styles} reviews={reviews} hasNext={hasNext} userId={userId}
        score={score} isAdmin={isAdmin} album={album} track={track} reviewType={reviewType} />
      <MoodStatus styles={styles} isMoodEmpty={isMoodEmpty} tags={tags}
        userId={userId} artist={artist} track={track}
        userVotedMoodId={userVotedMoodId} moodLabels={moodLabels} />
    </div>
  )
}

export default Track