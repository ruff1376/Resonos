import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'

const ArtistCard = ({artist, isOwner, onFollow}) => {

  const [isFollowed, setIsFollowed] = useState(true)

  const navigate = useNavigate()

  const handleClick = (id, e) => {
    if(e.target.tagName.toLowerCase() === 'button') {
      setIsFollowed(!isFollowed)
      onFollow(id)
      return
    }

    navigate(`/artists/${artist.id}`)
  }

  return (
    <li
      className="list-item"
      key={artist.id}
      onClick={(e) => handleClick(artist.id, e)}
    >
      <input type="hidden" value={artist.id} />
      <img
        src={artist.profileImage}
        alt={artist.name}
        className="follow-img"
      />
      <div className="info">
        <span className="follow-nick">{artist.name}</span>
      </div>
      {isOwner && (
        <button
          id="btn-follow"
          className="btn-outline-gold btn-sm follow-artist"
        >
          {
            isFollowed ? '언팔로우' : '팔로우'
          }
        </button>
      )}
    </li>
  )
}

export default ArtistCard