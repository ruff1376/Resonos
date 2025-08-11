import React, { useEffect, useState } from 'react'
import Playlist from '../../components/user/Playlist'
import * as ur from '../../apis/user'
import {MySwal} from '../../apis/alert'
import { useLocation, useNavigate, useParams } from 'react-router-dom'
import 'bootstrap/dist/css/bootstrap.min.css'


const PlaylistContainer = () => {

  const [likedPlaylists, setLikedPlaylists] = useState([])
  const [myPlaylists, setMyPlaylists] = useState([])
  const [lastPath, setLastPath] = useState('')
  const [isOwner, setIsOwner] = useState(false)

  const params = useParams()
  const location = useLocation()

  const navigate = useNavigate()

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

  const handleNavigate = (id) => {
    navigate(`/playlists/${id}`)
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
    } catch(e) {
      console.error('error :', e)
    }
  }

  useEffect(() => {
    getPlaylists()
  }, [])

  return (
    <div className='container'>
      <Playlist
        likedPlaylists={likedPlaylists}
        myPlaylists={myPlaylists}
        lastPath={lastPath}
        isOwner={isOwner}
        handleLike={handleLike}
        handleDelete={handleDelete}
        handleNavigate={handleNavigate}
      />
    </div>
  )
}

export default PlaylistContainer