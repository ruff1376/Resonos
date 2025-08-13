import React, { useEffect, useState } from 'react'
import LikedMusic from '../../components/user/LikedMusic'
import * as ur from '../../apis/user'
import {MySwal} from '../../apis/alert'
import { useParams } from 'react-router-dom'
import Header from '../../components/Header/Header';
import Footer from '../../components/Footer/Footer';

const LikedMusicContainer = () => {

  const params = useParams()

  const [countAlbum, setCountAlbum] = useState()
  const [countTrack, setCountTrack] = useState()
  const [isOwner, setIsOwner] = useState()
  const [lastPath, setLastPath] = useState()
  const [likedAlbumList, setLikedAlbumList] = useState([])
  const [likedTrackList, setLikedTrackList] = useState([])
  const [userId, setUserId] = useState()

  // 데이터 요청
  const getLikedMusic = async () => {
    let response
    try {
      if(params.id)
        response = await ur.getLikedMusic(params.id)
      else
        response = await ur.getLikedMusic()
      const data = response.data
      console.log(data)
      setCountAlbum(data.countAlbum)
      setCountTrack(data.countTrack)
      setIsOwner(data.isOwner)
      setLastPath(data.lastPath)
      setLikedAlbumList(data.likedAlbumList)
      setLikedTrackList(data.likedTrackList)
      setUserId(data.userId)
    } catch(e) {
      console.error('error :', e)
    }
  }

  // 좋아요 한 앨범 검색, 요청 함수
  const onSearchLikedTrack = async (keyword, offsetRef, limitRef, loadingRef, allLoadedRef) => {
    console.log(offsetRef.current)

    if (loadingRef.current || allLoadedRef.current) return

    loadingRef.current = true

    try {
      const { data } = await ur.searchLikedTrack({
        userId,
        keyword,
        offset: offsetRef.current,
        limit: limitRef.current
      })

      setLikedTrackList(prev => {
        const existingIds = new Set(prev.map(t => t.id))
        const filteredData = data.filter(t => !existingIds.has(t.id))
        return [...prev, ...filteredData]
      })

      offsetRef.current += limitRef.current

      console.log(offsetRef.current)

      if (data.length < limitRef.current) {
        allLoadedRef.current = true
      }
    } catch (err) {
      console.error(err)
    } finally {
      loadingRef.current = false
    }
  }

  // 트랙 좋아요 요청
  const onLikeTrack = async (trackId) => {
    try {
      const response = await ur.likeTrack({userId, trackId})
      const data = response.data
      if(response.status === 200) {
        const liked = data.liked
        const text = liked ? '좋아요를 완료했습니다.' : '좋아요를 취소했습니다.'
        setCountTrack(prev => liked ? prev + 1 : prev - 1)
        MySwal.fire({
          position: "center",
          icon: "success",
          title: text,
          showConfirmButton: false,
          timer: 800,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        })
      }
    } catch(e) {
      console.error('error :', e)
    }
  }

  // 좋아요 한 앨범 검색, 요청 함수
  const onSearchLikedAlbum = async (keyword, offsetRef, limitRef, loadingRef, allLoadedRef) => {
    console.log(offsetRef.current)
    if (loadingRef.current || allLoadedRef.current) return

    loadingRef.current = true

    try {
      const { data } = await ur.searchLikedAlbum({
        userId,
        keyword,
        offset: offsetRef.current,
        limit: limitRef.current
      })

      setLikedAlbumList(prev => {
        const existingIds = new Set(prev.map(t => t.id))
        const filteredData = data.filter(t => !existingIds.has(t.id))
        return [...prev, ...filteredData]
      })

      offsetRef.current += limitRef.current

      if (data.length < limitRef.current) {
        allLoadedRef.current = true
      }
    } catch (err) {
      console.error(err)
    } finally {
      loadingRef.current = false
    }
  }

  // 앨범 좋아요 요청
  const onLikeAlbum = async (albumId) => {
    try {
      const response = await ur.likeAlbum({userId, albumId})
      const data = response.data
      if(response.status === 200) {
        const liked = data.liked
        const text = liked ? '좋아요를 완료했습니다.' : '좋아요를 취소했습니다.'
        setCountAlbum(prev => liked ? prev + 1 : prev - 1)
        MySwal.fire({
          position: "center",
          icon: "success",
          title: text,
          showConfirmButton: false,
          timer: 800,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        })
      }
    } catch(e) {
      console.error('error :', e)
    }
  }

  // 마운트 시 데이터 요청
  useEffect(() => {
    getLikedMusic()
  }, [])

  return (
    <div className="admin container">
      <Header />
      <LikedMusic
        countAlbum={countAlbum}
        countTrack={countTrack}
        isOwner={isOwner}
        lastPath={lastPath}
        likedAlbumList={likedAlbumList}
        likedTrackList={likedTrackList}
        setLikedAlbumList={setLikedAlbumList}
        setLikedTrackList={setLikedTrackList}
        userId={userId}
        onLikeAlbum={onLikeAlbum}
        onLikeTrack={onLikeTrack}
        onSearchLikedAlbum={onSearchLikedAlbum}
        onSearchLikedTrack={onSearchLikedTrack}
      />
      <Footer />
    </div>
  )
}

export default LikedMusicContainer