import React from 'react'

const ReviewScore = ({ styles, score }) => {
  return (
    <>
      {score == null ? (
        <h1 className={styles.headline}>첫 리뷰를 작성해보세요 🤩</h1>
      ) : (
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
      )}
    </>
  )
}

export default ReviewScore