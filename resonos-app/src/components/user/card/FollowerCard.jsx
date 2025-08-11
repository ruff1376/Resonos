import React from 'react'
import { useNavigate } from 'react-router-dom'

const FollowerCard = ({follower}) => {

  const navigate = useNavigate()

  const handleClick = () => {
    navigate(`/users/${follower.id}`)
  }

  return (
    <li
      className="list-item"
      onClick={handleClick}
    >
      <img
        src={follower.profileImage}
        alt="프로필 이미지"
        className="follow-img"
      />
      <div className="info">
        <span className="follow-nick">{follower.nickname}</span>
      </div>
    </li>
  )
}

export default FollowerCard