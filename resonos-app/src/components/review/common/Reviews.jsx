import React from 'react'

const Reviews = ({ styles, reviews, reviewType, size, isAdmin, loginUser, hasNext}) => {
  return (
    <>
      {reviews.slice(0, size).map((rv, index) => (
        <li
          key={rv.id}
          className={styles.comment}
          id={`rv-${rv.id}`}
          data-review-id={rv.id}
          data-track-id={reviewType === 'TRACK' ? rv.trackId : null}
          data-album-id={reviewType === 'ALBUM' ? rv.albumId : null}
        >
          <div className={styles.nameAndScore}>
            <a href={`/users/${rv.reviewer.id}`}>
              <p>{rv.reviewer.nickname}</p>
            </a>
            {rv.critic && <span>✅</span>}
            <span> 🔮<span>{rv.rating}</span></span>
          </div>

          {rv.blinded ? (
            <>
              {isAdmin ? (
                <div className="review-content">
                  <p style={{ color: 'crimson', fontWeight: 'bold' }}>블라인드 리뷰 내용 - </p>
                  <p className="content-text">{rv.content}</p>
                </div>
              ) : (
                <div className="review-content">
                  <p className="content-text" style={{ color: 'gray' }}>
                    누적된 신고로 인해 블라인드 처리된 리뷰입니다.
                    <button
                      className="btn btn-gold show-blind-btn"
                      data-review-id={rv.id}
                      style={{ fontSize: '1.4rem' }}
                      onClick={() => handleShowBlindContent(rv.id)}
                    >
                      블라인드 내용 보기
                    </button>
                  </p>
                  <p
                    className="blind-content"
                    id={`blind-content-${rv.id}`}
                    style={{
                      display: showBlindContent[rv.id] ? 'block' : 'none',
                      color: 'gray',
                      marginTop: '0.5rem',
                    }}
                  >
                    {rv.content}
                  </p>
                </div>
              )}
            </>
          ) : (
            <div className="review-content">
              <p className="content-text">{rv.content}</p>
            </div>
          )}

          <form className={styles.editForm} style={{ display: 'none' }}>
            <div className={styles.reply}>
              <textarea className={styles.editContent} required></textarea>
              <div className={styles.scoreAndSubmit}>
                <input type="number" className={styles.editRating} min="0" max="100" required />
                <div className="button-box">
                  <button type="submit" className="btn btn-gold">수정 완료</button>
                  <button type="button" className="btn btn-danger">취소</button>
                </div>
              </div>
            </div>
          </form>

          <div className={styles.reviewUtil}>
            <time>{new Date(rv.createdAt).toLocaleDateString('ko-KR')}</time>

            <button
              className={styles.likeBtn}
              data-review-id={rv.id}
              data-review-type={reviewType}
              data-liked={rv.isLikedByCurrentUser}
            >
              {rv.isLikedByCurrentUser ? '❤️' : '🤍'}
            </button>
            <span id={`like-count-${rv.id}`}>{rv.likes}</span>

            <button className={styles.reportBtn} data-review-id={rv.id} data-review-type={reviewType}>🚨</button>
            {isAdmin && <span style={{ color: 'red' }}>{rv.dislikes}</span>}
            {(isAdmin || (loginUser && loginUser.id === rv.userId)) && (
              <span>
                <a href="#" className="edit-btn" data-id={rv.id}>수정</a>
                <a href="#" className="del-btn" data-id={rv.id}>삭제</a>
              </span>
            )}
          </div>
        </li>
      ))}
      <li id="has-next-flag" style={{ display: 'none' }} data-has-next={hasNext}></li>
    </>
  )
}

export default Reviews