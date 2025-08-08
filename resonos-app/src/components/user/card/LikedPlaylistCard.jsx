import React, { useState } from 'react'

const LikedPlaylistCard = ({lpl, isOwner, onLike, onNavigate}) => {

  const [isLiked, setIsLiked] = useState(true)

  const handleClick = (e) => {
      if (e.target.tagName.toLowerCase() === 'button') {
        onLike(lpl.id, isLiked)
        setIsLiked(!isLiked)
        e.stopPropagation();
        return;
      }
      onNavigate(lpl.id);
    }

  return (
    <li className="list-item" key={lpl.id} onClick={handleClick}>
      <input type="hidden" value={lpl.id} name="id" />
      <img
        src={lpl.thumbnailUrl}
        className="follow-img"
        alt={lpl.title}
      />
      <div className="info">
        <span className="name-album">{lpl.title}</span>
        <span className="name-user">{lpl.ownerName}</span>
      </div>
      {isOwner && (
        <button className="like like-button already">
          {
            isLiked ? '♥' : '♡'
          }
        </button>
      )}
    </li>
  )
}

export default LikedPlaylistCard