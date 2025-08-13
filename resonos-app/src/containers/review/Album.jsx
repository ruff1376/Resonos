import React, { useEffect, useState } from 'react'
import * as api from "../../apis/review"
import { Link, useParams, useSearchParams } from 'react-router-dom'
import styles from './Album.module.css'
import AlbumInfo from '../../components/review/album/AlbumInfo';
import swal from 'sweetalert2';
import withReactContent from 'sweetalert2-react-content'
import AlbumStatus from '../../components/review/album/AlbumStatus';
import MvAndStreaming from '../../components/review/common/MvAndStreaming';
import Review from '../../components/review/common/Review';



const Album = () => {

  const [searchParams] = useSearchParams();
  const id = searchParams.get('id');

  // 앨범 기본 정보
  const [album, setAlbum] = useState({});
  const [artist, setArtist] = useState({});
  const [tracks, setTracks] = useState([]);
  const [top5List, setTop5List] = useState([]);
  const [topTrack, setTopTrack] = useState({});

  // 리뷰 및 좋아요 정보
  const [reviews, setReviews] = useState([]);
  const [score, setScore] = useState({});
  const [albumLikeCount, setAlbumLikeCount] = useState(0);
  const [isAlbumLikedByUser, setIsAlbumLikedByUser] = useState(false);
  const [hasNext, setHasNext] = useState(false);

  // 플레이리스트 정보
  const [emptyPlayList, setEmptyPlayList] = useState(true);
  const [playLists, setPlayLists] = useState([]);

  // 앨범 6요소 및 투표 정보
  const [isArgEmpty, setIsArgEmpty] = useState(true);
  const [argValues, setArgValues] = useState({});
  const [userVote, setUserVote] = useState({});

  // 기타 정보
  const [tags, setTags] = useState([]);
  const [isAdmin, setIsAdmin] = useState(false);
  const [userId, setUserId] = useState({});
  const [reviewType, setReviewType] = useState("")

  useEffect(() => {
    const fetchData = async () => {
      if (id) {
        console.log('API 호출 시작, ID:', id);
        try {
          // axios 응답 객체 전체를 받음
          const response = await api.getAlbumPage(id);
          // console.log(await albumApi.albumPage(id))
          // 실제 데이터는 response.data에 들어있음
          const data = response.data;
          console.log('API 응답 데이터:', data);

          // 응답 데이터를 기반으로 각 상태 업데이트
          setAlbum(data.album);
          setArtist(data.artist);
          setTracks(data.tracks);
          setTop5List(data.top5List);
          setTopTrack(data.topTrack);

          setReviews(data.reviews);
          setScore(data.score);
          setAlbumLikeCount(data.albumLikeCount);
          setIsAlbumLikedByUser(data.isAlbumLikedByUser);
          setHasNext(data.hasNext);

          setEmptyPlayList(data.emptyPlayList);
          setPlayLists(data.playLists);

          setIsArgEmpty(data.isArgEmpty);
          setArgValues(data.argValues);
          setUserVote(data.userVote);

          setTags(data.tags);
          setIsAdmin(data.isAdmin);
          setUserId(data.userId);
          setReviewType(data.reviewType);
        } catch (error) {
          console.error('API 호출 실패:', error);
        }
      }
    };

    fetchData();
  }, [id]);
  const releaseDate = new Date(album.releaseDate);
  const formattedDate = releaseDate.toLocaleDateString('ko-KR', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit'
  });
  album.releaseDate = formattedDate;



  // 앨범 좋아요
  const toggleLike = async (userId, album) => {
    try {
      const response = await api.toggleLike(userId, album.id);
      console.log(response.data)
      setIsAlbumLikedByUser(response.data.liked);
      setAlbumLikeCount(response.data.count)
    } catch (error) {
      console.error(error);
      if (error.response.data === 'User is null') {
        swal.fire('로그인이 필요합니다', '로그인시 사용 가능한 기능입니다.', 'warning')
      } else {
        swal.fire('실패', '좋아요 실패', 'error')
      }
    }
  }

  const handleLikeClick = (userId, album) => {
    toggleLike(userId, album);
  }

  // 앨범 리뷰 작성

  return (
    <>
      <div className={styles.albumWrapper}>
        
        <AlbumInfo handleLikeClick={handleLikeClick} styles={styles}
          album={album} artist={artist} score={score}
          isAlbumLikedByUser={isAlbumLikedByUser} albumLikeCount={albumLikeCount}
          tracks={tracks} userId={userId} />
        <MvAndStreaming styles={styles} tracks={tracks} track={topTrack} />
        <AlbumStatus styles={styles} album={album}
          top5List={top5List} isArgEmpty={isArgEmpty}
          argValues={argValues} emptyPlayList={emptyPlayList}
          playLists={playLists} />
        <Review styles={styles} reviews={reviews} hasNext={hasNext} userId={userId}
          score={score} isAdmin={isAdmin} album={album} reviewType={reviewType} track={null} />
        {/* <Element styles={styles} album={album} isArgEmpty={isArgEmpty}
          argValues={argValues} userVote={userVote} userId={userId}
          isAdmin={isAdmin} /> */}
      </div>
    </>
  )
}

export default Album
