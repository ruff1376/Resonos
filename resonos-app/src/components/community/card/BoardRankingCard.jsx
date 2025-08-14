import React from 'react'
import { useNavigate } from 'react-router-dom'

const BoardRankingCard = ({title, rank}) => {

  const navigate = useNavigate()

  const handleNavigate = () => {
    // TODO: 게시글 ID 받아와서 navigate
    alert('데이터 주세요')
  }

  return (
    <li>
      <p>{title}</p><span>{rank}</span>
    </li>
  )
}

export default BoardRankingCard