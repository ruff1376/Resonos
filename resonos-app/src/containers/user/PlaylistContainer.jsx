import React, { useEffect, useState } from 'react'
import Playlist from '../../components/user/Playlist'
import * as ur from '../../apis/user'
import { useLocation, useNavigate, useParams } from 'react-router-dom'
import 'bootstrap/dist/css/bootstrap.min.css';

const PlaylistContainer = () => {

  const [likedPlaylists, setLikedPlaylists] = useState([])
  const [myPlaylists, setMyPlaylists] = useState([])
  const [lastPath, setLastPath] = useState('')
  const [isOwner, setIsOwner] = useState(false)

  const params = useParams()
  const location = useLocation()

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
      />
    </div>
  )
}

export default PlaylistContainer