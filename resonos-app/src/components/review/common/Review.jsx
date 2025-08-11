import React from 'react'

const review = () => {
  return (
    <>
      {/* 평점 리뷰 */}
      <div className="review-card">
        <p id="headline">평점 & 리뷰</p>
        <div className="review-score">
          {score && score.averageScore ? (
            <>
              <h1 id="headline" style={{ padding: '10px' }}>
                🔮 {score.averageScore.toFixed(0)}
              </h1>
              <div className="score-bar">
                <div
                  className="score-fill"
                  style={{ width: `${score.averageScore.toFixed(1)}%` }}
                >
                  <span>{score.averageScore.toFixed(0)}</span>
                </div>
              </div>
            </>
          ) : (
            <h1 id="headline" style={{ padding: '10px' }}>
              첫 리뷰를 작성해보세요 🤩
            </h1>
          )}
        </div>
        <div className="review-container">
          <ul className="review-list">
            {reviews && reviews.map((review) => (
              <li key={review.id}>
                <div className="review-header">
                  {/* 리뷰어의 닉네임과 프로 여부를 표시합니다. */}
                  {review.reviewer && (
                    <>
                      <span className="nickname">{review.reviewer.nickname}</span>
                      {review.reviewer.isPro && <span className="pro-tag">⭐</span>}
                    </>
                  )}
                  {/* 평점과 작성일자를 표시합니다. */}
                  <span className="rating">{review.rating}점</span>
                  <span className="created-at">{review.createdAt}</span>
                </div>
                <div className="review-content">
                  {review.content}
                </div>
                <div className="review-actions">
                  {/* 좋아요 버튼과 좋아요 수를 표시합니다. */}
                  <button type="button">
                    {review.isLikedByCurrentUser ? '❤️' : '🤍'}
                    <span>{review.likes}</span>
                  </button>
                  {/* TODO: 좋아요/싫어요 토글 로직 추가 */}
                </div>
              </li>
            ))}
          </ul>
          {hasNext && (
            <div className="d-flex justify-content-center mb-1">
              <div className="more-box d-flex gap-3">
                <button id="load-more-btn" className="btn btn-gold">
                  리뷰 더보기
                </button>
              </div>
            </div>
          )}
          {/* 로그인 여부에 따른 리뷰 작성 UI */}
          {/* loginUser는 DTO에 없으므로 isAdmin으로 대체 */}
          {!isAdmin ? (
            <div className="d-flex gap-3 align-items-center">
              <p id="headline" style={{ padding: '10px', marginBottom: '0px' }}>
                로그인시 리뷰작성과 점수투표가 가능합니다.
              </p>
              <Link id="login-review" to="/login" className="btn btn-gold">
                로그인
              </Link>
            </div>
          ) : (
            <ReviewForm albumId={album.id} />
          )}
        </div>
      </div>
      {/* 평점 리뷰 끝 */}
    </>
  )
}

export default review