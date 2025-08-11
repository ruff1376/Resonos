import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'

const LikedTrackCard = ({track, isOwner, onLikeTrack}) => {

  const [isLiked, setIsLiked] = useState(true)
  const navigate = useNavigate()

  const handleNavigate = e => {
    if(e.target.tagName.toLowerCase() === 'button') {
      onLikeTrack(track.id)
      setIsLiked(!isLiked)
      return
    }
    navigate(`/tracks?id=${track.id}`)
  }

  return (
    <li
      className="list-item"
      onClick={e => handleNavigate(e)}
    >
      <img
        src={track.coverImage}
        alt="GalaxiNote"
        className="follow-img"
      />
      <div className="info">
        <span className="name-album">{track.title}</span>
        <span className="name-artist">{track.artistName}</span>
      </div>
      {isOwner && (
        <button type="button" className="like like-track">
          {
            isLiked ? '♥' : '♡'
          }
        </button>
      )}
    </li>
  )
}

export default LikedTrackCard