import React, { useEffect } from 'react'
import * as ur from '../../apis/user'
import { useParams } from 'react-router-dom'

const PlaylistDetailContainer = () => {

  const params = useParams()

  const getPlaylistDetail = async () => {
    try {
      const response = await ur.getPlaylistDetail(params.id)
      console.log(response.data)
    } catch(e) {
      console.error('error :', e)
    }
  }

  useEffect(() => {
    getPlaylistDetail()
  }, [])

  return (
    <div>PlaylistDetailContainer</div>
  )
}

export default PlaylistDetailContainer