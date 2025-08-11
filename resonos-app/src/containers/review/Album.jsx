import React, { useEffect, useState } from 'react'
import * as albumApi from "../../apis/review"
import { Link, useParams, useSearchParams } from 'react-router-dom'
import Info from '../../components/review/common/Info';
import styles from './Album.module.css'
import AlbumInfo from '../../components/review/album/AlbumInfo';

const Album = () => {

  const [searchParams] = useSearchParams();
  const id = searchParams.get('id');

  // 앨범 6요소
  const album6Elements = ['대중성', '음악성', '사운드', '가창력', '독창성', '수록곡'];

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

  useEffect(() => {
    const fetchData = async () => {
      if (id) {
        console.log('API 호출 시작, ID:', id);
        try {
          // axios 응답 객체 전체를 받음
          const response = await albumApi.getAlbumPage(id);
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
      const response = await albumApi.toggleLike(userId, album.id);
      console.log(response.data)
      setIsAlbumLikedByUser(response.data.liked);
      setAlbumLikeCount(response.data.count)
    } catch (error) {
      console.error(error);
      // 에러 Swal 띄울예정
    }
  }

  const handleLikeClick = (userId, album) => {
    toggleLike(userId, album);
  }

  useEffect(() => {
    // 좋아요 Swal 띄울예정
  }, [isAlbumLikedByUser, albumLikeCount])

  // 앨범 리뷰 작성

  return (
    <>
      <div className={styles.albumWrapper}>
        {/* 앨범 트랙리스트 분위기 뭐뭐.. */}
        <AlbumInfo handleLikeClick={handleLikeClick} styles={styles}
                  album={album} artist={artist} 
                  isAlbumLikedByUser={isAlbumLikedByUser} albumLikeCount={albumLikeCount}
                  tracks={tracks} userId={userId} />
        <div className={styles.infoCard}>
          <div className={`${styles.info} ${styles.top5track}`}>
            <p className={styles.headline}>{`${album.title}💽 TOP${top5List.length}🔥`}</p>
            {top5List.map((tops, index) => (
              <Link key={tops.id} to={`/tracks?id=${tops.id}`}>
                <div className="d-flex gap-3" style={{ maxHeight: 'fit-content' }}>
                  <p
                    style={{
                      maxWidth: '300px',
                      whiteSpace: 'nowrap',
                      overflow: 'hidden',
                      textOverflow: 'ellipsis',
                    }}
                  >
                    {`${index + 1}. ${tops.title}`}
                  </p>
                  <span>{tops.formattedDuration}</span>
                </div>
              </Link>
            ))}
          </div>
          <div className={`${styles.info} ${styles.albumMoods}`}>
            <p className={styles.headline}>앨범의 평균 점수</p>
            {isArgEmpty ? (
              <p>아직 아무도 투표하지 않았어요</p>
            ) : (
              <div className={styles.scoreInfo}>
                {argValues && Object.keys(argValues).map((score, index) => (
                  <div key={index}>
                    <p>{`${album6Elements[index]}:`}</p>
                    <span>{score}점</span>
                  </div>
                ))}
              </div>
            )}
          </div>

        </div>
        {/* 앨범 트랙리스트 분위기 뭐뭐.. 끝 */}

      </div>
    </>
  )
}

export default Album
