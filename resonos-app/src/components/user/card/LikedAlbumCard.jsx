import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'

const LikedAlbumCard = ({album, isOwner, onLikeAlbum}) => {

  const [isLiked, setIsLiked] = useState(true)
  const navigate = useNavigate()

  const handleNavigate = e => {
    if(e.target.tagName.toLowerCase() === 'button') {
      onLikeAlbum(album.id)
      setIsLiked(!isLiked)
      return
    }
    navigate(`/albums?id=${album.id}`)
  }

  return (
    <li
      className="list-item"
      onClick={e => handleNavigate(e)}
    >
      <img
        src={album.coverImage}
        alt="GalaxiNote"
        className="follow-img"
      />
      <div className="info">
        <span className="name-album">{album.title}</span>
        <span className="name-artist">{album.artistName}</span>
      </div>
      {isOwner && (
        <button type="button" className="like like-album">
          {
            isLiked ? '♥' : '♡'
          }
        </button>
      )}
    </li>
  )
}

export default LikedAlbumCard