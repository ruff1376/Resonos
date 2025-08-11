import React, { useCallback, useEffect, useRef, useState } from 'react'
import { Link } from 'react-router-dom'

// onChange 이벤트 디바운스
function useDebounce(value, delay) {
  const [debouncedValue, setDebouncedValue] = useState(value)
  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value)
    }, delay)
    return () => {
      clearTimeout(handler)
    }
  }, [value, delay])
  return debouncedValue
}

const TrackReviewCard = ({countTReview, tReviewList, onSearchReview, setTReviewList}) => {

  const [keyword, setKeyword] = useState('')
  const debouncedKeyword = useDebounce(keyword, 300)

  const offsetRef = useRef(0);
  const limitRef = useRef(20);
  const loadingRef = useRef(false);
  const allLoadedRef = useRef(false);

  // 스크롤로 트랙 20개씩 추가 요청
  const handleScroll = useCallback(() => {
    if (loadingRef.current || allLoadedRef.current) return
    const container = document.querySelector('.info-section.tr')
    const nearBottom = container.scrollTop + container.clientHeight >= container.scrollHeight - 150
    if (nearBottom && !loadingRef.current && !allLoadedRef.current) {
      console.log('데이터 요청')
      onSearchReview(debouncedKeyword, offsetRef, limitRef, loadingRef, allLoadedRef, 'tr')
    }
  }, [onSearchReview, debouncedKeyword])

  // 스크롤 함수 추가
  useEffect(() => {
    const container = document.querySelector('.info-section.tr');
    if (!container) return;

    container.addEventListener('scroll', handleScroll);
    return () => {
      const container = document.querySelector('.info-section.tr');
      if (container) {
        container.removeEventListener('scroll', handleScroll);
      }
    }
  }, [handleScroll])

  // 키워드 바뀌면 offset 0 으로 초기화
  useEffect(() => {
    offsetRef.current = 0
    allLoadedRef.current = false
  }, [debouncedKeyword])

  // 키워드 바뀌면 새로 참조할 수 있게 요청 초기화
  useEffect(() => {

    offsetRef.current = 0
    allLoadedRef.current = false
    setTReviewList([])

    onSearchReview(debouncedKeyword, offsetRef, limitRef, loadingRef, allLoadedRef, 'tr')
  }, [debouncedKeyword, setTReviewList])

  return (
    <section className="info-wrapper">
      <div className="info-section tr">
        <div className="title">
          <div>
            <h2 className="text-start">내가 쓴 트랙 리뷰</h2>
            <span className="count">{countTReview}</span>
          </div>
          <div className="text-center position-relative">
            <i className="bi bi-search search-icon position-absolute"></i>
            <input
              id="tr-search"
              type="text"
              className="basic-input"
              name="keyword"
              placeholder="제목, 내용"
              onChange={e => setKeyword(e.target.value)}
            />
          </div>
        </div>
        <ul className="ul-list tr">
          {tReviewList.map((review) => (
            <li className="text-item" key={review.id}>
              <Link to={`/tracks?id=${review.trackId}&reviewId=${review.id}`}>
                <p className="sm-title">{review.title}</p>
                <p className="sm-content">{review.content}</p>
                <span className="date">
                  {new Date(review.createdAt).toLocaleString()}
                </span>
                <span className="like">❤️ {review.likes}</span>
              </Link>
            </li>
          ))}
        </ul>
      </div>
    </section>
  )
}

export default TrackReviewCard