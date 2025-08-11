import React, { useEffect, useState } from 'react'
import * as albumApi from "../../apis/review"
import { Link, useParams, useSearchParams } from 'react-router-dom'




const Album = () => {

  const [searchParams] = useSearchParams();
  const id = searchParams.get('id');

  // 앨범 기본 정보
  const [album, setAlbum] = useState(null);
  const [artist, setArtist] = useState(null);
  const [tracks, setTracks] = useState([]);
  const [top5List, setTop5List] = useState([]);
  const [topTrack, setTopTrack] = useState(null);

  // 리뷰 및 좋아요 정보
  const [reviews, setReviews] = useState([]);
  const [score, setScore] = useState(null);
  const [albumLikeCount, setAlbumLikeCount] = useState(0);
  const [isAlbumLikedByUser, setIsAlbumLikedByUser] = useState(false);
  const [hasNext, setHasNext] = useState(false);

  // 플레이리스트 정보
  const [emptyPlayList, setEmptyPlayList] = useState(true);
  const [playLists, setPlayLists] = useState([]);

  // 앨범 6요소 및 투표 정보
  const [isArgEmpty, setIsArgEmpty] = useState(true);
  const [argValues, setArgValues] = useState({});
  const [userVote, setUserVote] = useState(null);

  // 기타 정보
  const [tags, setTags] = useState([]);
  const [isAdmin, setIsAdmin] = useState(false);
  const [userId, setUserId] = useState(null);

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

  const handleLikeClick = () => {
    if (isAlbumLikedByUser) {
      isAlbumLikedByUser(false);

    } else {
      isAlbumLikedByUser(true);
    }
  }


  return (
    <>
      
    </>
  )
}

export default Album