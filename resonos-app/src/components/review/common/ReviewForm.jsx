import React from 'react'

const ReviewForm = ({ styles, albumId, handleSubmit}) => {
  return (
    <div className={styles.reply}>
      <form id="reviewForm" onSubmit={handleSubmit}>
        <input type="hidden" id="albumId" value={albumId} />
        <textarea
          id="content"
          placeholder="리뷰를 입력해주세요"
          required
          // value={content}
          onChange={(e) => setContent(e.target.value)}
        ></textarea>
        <div className="score-and-submit">
          <input
            type="number"
            id="rating"
            min="0"
            max="100"
            placeholder="0~100점"
            required
            // value={rating}
            onChange={(e) => setRating(e.target.value)}
          />
          <button type="submit" className="btn btn-gold">
            리뷰작성
          </button>
        </div>
      </form>
    </div>
  )
}

export default ReviewForm