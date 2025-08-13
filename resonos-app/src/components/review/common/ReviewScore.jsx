import React from 'react'

const ReviewScore = ({ styles, score }) => {
  return (
    <>
      <h1 className={styles.headline}>🔮 {Math.floor(score.averageScore)}</h1>
      <div className={styles.scoreBar}>
        <div
          className={styles.scoreFill}
          style={{ width: `${score.averageScore.toFixed(1)}%` }}
        >
          <span>{Math.floor(score.averageScore)}</span>
        </div>
      </div>
    </>
  )
}

export default ReviewScore