import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'

const TrackCard = ({track, isOwner, onDelete, onLike}) => {

  const [requestLiked, setRequestLiked] = useState(false)
  const navigate = useNavigate()


  const handleDelete = (e) => {
    e.stopPropagation()
    onDelete(track.orderNo)
  }

  const handleLike = (e, trackId) => {
    e.stopPropagation()
    onLike(trackId)
    setRequestLiked(!requestLiked)
  }

  const moveToTrack = () => {
    navigate(`/track/${track.id}`)
  }

  return (
    <li className="list-item" key={track.id} onClick={moveToTrack}>
      <input type="hidden" value={track.id} />
      <p className="order-no">{track.orderNo}</p>
      <img src={track.coverImage} className="follow-img" alt="트랙 커버" />
      <div className="info">
        <span className="name-album">{track.title}</span>
        <span className="name-artist">{track.artistName}</span>
      </div>
      {isOwner && (
        <div className="right">
          {track.liked && (
            <button
              type="button"
              className="like like-track"
              onClick={(e) => handleLike(e, track.id)}
            >
              {
                !requestLiked ? '♥' : '♡'
              }
            </button>
          )}
          <button
            type="button"
            className="btn btn-danger"
            onClick={handleDelete}
          >
            삭제
          </button>
        </div>
      )}
    </li>
  )
}

export default TrackCard