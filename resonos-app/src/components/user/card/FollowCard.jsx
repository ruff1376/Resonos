import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'

const FollowCard = ({follow, isOwner, onFollowUser}) => {

  const navigate = useNavigate()
  const [isFollowed, setIsFollowed] = useState(true)

  const handleClick = (e) => {
    if(e.target.tagName.toLowerCase() === 'button') {
      onFollowUser(follow.id, isFollowed)
      setIsFollowed(!isFollowed)
      return
    }
    navigate(`/users/${follow.id}`)
  }

  return (
    <li
      className="list-item"
      onClick={e => handleClick(e)}
    >
      <img
        src={follow.profileImage}
        alt="프로필 이미지"
        className="follow-img"
      />
      <div className="info">
        <span className="follow-nick">{follow.nickname}</span>
      </div>
      {isOwner && (
        <button
          id="btn-follow"
          className="btn-outline-gold btn-sm already"
        >
          {
            isFollowed ? '언팔로우' : '팔로우'
          }
        </button>
      )}
    </li>
  )
}

export default FollowCard