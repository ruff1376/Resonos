import React from 'react'
import InfoScore from './InfoScore'
import { Link } from 'react-router-dom'
import ReviewScore from './ReviewScore'
import Reviews from './Reviews'
import ReviewForm from './ReviewForm'

const Review = ({ reviewType, score, styles, reviews, hasNext, userId, isAdmin, album, track }) => {
  return (
    <>
      {/* 평점 리뷰 */}
      <div className={styles.reviewCard}>
        <p className={styles.headline}>평점 & 리뷰</p>
        <div className={styles.reviewScore}>
          {/* 리뷰칸 점수 컴포넌트 */}
          {score != null && score.averageScore !== undefined ? (
            <ReviewScore score={score} styles={styles} />
          )
          :
          (
            <h1 className={styles.headline}>첫 리뷰를 작성해보세요 🤩</h1>
          )}
        </div>
        <div className="review-container">
          <ul className={styles.reviewList}>
            {reviews != null && reviews.length > 0 ? (
              <Reviews reviews={reviews} reviewType={reviewType} size={5}
                isAdmin={isAdmin} hasNext={hasNext} styles={styles} />
            )
              :
              <>
              </>
            }
          </ul>
          {hasNext && (
            <div className="d-flex justify-content-center mb-1">
              <div className="more-box d-flex gap-3">
                <button id="load-more-btn" className={`btn ${styles['btn-gold']}`}>
                  리뷰 더보기
                </button>
              </div>
            </div>
          )}
          {/* 로그인 여부에 따른 리뷰 작성 UI */}
          {userId == null ? (
            <div className="d-flex gap-3 align-items-center">
              <p className={styles.headline} style={{ padding: '10px', marginBottom: '0px' }}>
                로그인시 리뷰작성과 점수투표가 가능합니다.
              </p>
              <Link id="login-review" to="/login" className={`btn ${styles['btn-gold']}`}>
                로그인
              </Link>
            </div>
          ) : (
            <ReviewForm styles={styles} reviewType={reviewType} albumId={album.id} trackId={track} />
          )}
        </div>
      </div>
      {/* 평점 리뷰 끝 */}
    </>
  )
}

export default Review