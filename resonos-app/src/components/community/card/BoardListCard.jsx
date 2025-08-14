import React from 'react'
import { useNavigate } from 'react-router-dom'

const BoardListCard = ({title}) => {

  const navigate = useNavigate()

  const handleNavigate = () => {
    // TODO: 게시글 ID 받아와서 navigate
    alert('데이터 주세요')
  }

  return (
    <li onClick={handleNavigate}>
      <p>{title}</p>
      <div>
        <span className='post-name'>게시판이름</span>
        <span className='date'>10:05</span>
      </div>
    </li>
  )
}

export default BoardListCard