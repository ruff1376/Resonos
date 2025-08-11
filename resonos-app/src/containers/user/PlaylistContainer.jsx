import React, { useEffect, useState } from 'react'
import Playlist from '../../components/user/Playlist'
import * as ur from '../../apis/user'
import {MySwal} from '../../apis/alert'
import { useLocation, useNavigate, useParams } from 'react-router-dom'
import 'bootstrap/dist/css/bootstrap.min.css'
import Header from '../../components/Header/Header';
import Footer from '../../components/Footer/Footer';


const PlaylistContainer = () => {

  const [likedPlaylists, setLikedPlaylists] = useState([])
  const [myPlaylists, setMyPlaylists] = useState([])
  const [lastPath, setLastPath] = useState('')
  const [isOwner, setIsOwner] = useState(false)
  const [userId, setUserId] = useState()

  const params = useParams()
  const location = useLocation()

  const navigate = useNavigate()

  // 플레이리스트 좋아요 요청
  const handleLike = async (id, isLiked) => {
    try {
      let response
      if(isLiked)
        response = await ur.cancelLikePlaylist(id)
      else
        response = await ur.likePlaylist(id)

      if(response.status === 200) {
        // 성공시
        const text = response.data
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
        });
      }
    } catch(e) {
      console.error('error :', e)
    }
  }

  // 내 플레이리스트 삭제 요청
  const handleDelete = async (id) => {
    try {
      const response = await ur.deletePlaylist(id)
      if(response.status === 200) {
        MySwal.fire({
          position: "center",
          icon: "success",
          title:  "삭제되었습니다.",
          showConfirmButton: false,
          timer: 800,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        });
        // 데이터 다시 가져오기
        getPlaylists()
      }
    } catch(e) {
      console.error('error :', e)
    }
  }

  // 플레이리스트 상세 페이지 이동
  const handleNavigate = (id) => {
    navigate(`/playlists/${id}`)
  }

  // 좋아요한 플레이리스트 검색, 요청
  const onSearchPlaylist = async (keyword, offsetRef, limitRef, loadingRef, allLoadedRef) => {
    console.log(keyword)
    if (loadingRef.current || allLoadedRef.current) return

    loadingRef.current = true

    try {
      const { data } = await ur.searchMyLikedPlaylist({
        userId,
        keyword,
        offset: offsetRef.current,
        limit: limitRef.current,
      })

      setLikedPlaylists(prev => {
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

  // 플레이리스트 데이터 요청
  const getPlaylists = async () => {
    try {
      const response = await ur.getUserPlaylists(params.id)
      const data = response.data
      console.log(data)
      // state 세팅
      setLikedPlaylists(data.likedPlaylists)
      setMyPlaylists(data.myPlaylists)
      setLastPath(data.lastPath)
      setIsOwner(data.isOwner)
      setUserId(data.userId)
    } catch(e) {
      console.error('error :', e)
    }
  }

  // 마운트 시 데이터 요청
  useEffect(() => {
    getPlaylists()
  }, [])

  return (
    <div className='container'>
      <Header />
      <Playlist
        likedPlaylists={likedPlaylists}
        setLikedPlaylists={setLikedPlaylists}
        myPlaylists={myPlaylists}
        lastPath={lastPath}
        isOwner={isOwner}
        handleLike={handleLike}
        handleDelete={handleDelete}
        handleNavigate={handleNavigate}
        onSearchPlaylist={onSearchPlaylist}
      />
      <Footer />
    </div>
  )
}

export default PlaylistContainer