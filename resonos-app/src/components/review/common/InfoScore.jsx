import React from 'react'

const InfoScore = ({ score, styles }) => {
  return (
    <div className="review-section">
      {score == null ? (
        <p>아직 리뷰가 없어요 😅</p>
      ) : (
        <p>
          🔮 <span className="score">{Math.floor(score.averageScore)}</span>점
          (✅리뷰 <span className="critic-count">{score.criticCount}</span>개,
          일반리뷰 <span className="user-count">{score.userCount}</span>개)
        </p>
      )}
    </div>
  )
}

export default InfoScore