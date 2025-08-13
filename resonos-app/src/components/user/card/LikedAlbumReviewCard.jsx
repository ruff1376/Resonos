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

const LikedAlbumReviewCard = ({countLaReview, laReviewList, onSearchReview, setLaReviewList}) => {

  const [keyword, setKeyword] = useState('')
  const debouncedKeyword = useDebounce(keyword, 300)

  const offsetRef = useRef(0);
  const limitRef = useRef(20);
  const loadingRef = useRef(false);
  const allLoadedRef = useRef(false);

  // 스크롤로 트랙 20개씩 추가 요청
  const handleScroll = useCallback(() => {
    if (loadingRef.current || allLoadedRef.current) return
    const container = document.querySelector('.info-section.lar')
    const nearBottom = container.scrollTop + container.clientHeight >= container.scrollHeight - 150
    if (nearBottom && !loadingRef.current && !allLoadedRef.current) {
      console.log('데이터 요청')
      onSearchReview(debouncedKeyword, offsetRef, limitRef, loadingRef, allLoadedRef, 'lar')
    }
  }, [onSearchReview, debouncedKeyword])

  // 스크롤 함수 추가
  useEffect(() => {
    const container = document.querySelector('.info-section.lar');
    if (!container) return;

    container.addEventListener('scroll', handleScroll);
    return () => {
      const container = document.querySelector('.info-section.lar');
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
    setLaReviewList([])

    onSearchReview(debouncedKeyword, offsetRef, limitRef, loadingRef, allLoadedRef, 'lar')
  }, [debouncedKeyword, setLaReviewList])

  return (
    <section className="info-wrapper">
      <div className="info-section lar">
        <div className="title">
          <div>
            <h2 className="text-start">좋아요 한 앨범 리뷰</h2>
            <span className="count">{countLaReview}</span>
          </div>
          <div className="text-center position-relative">
            <i className="bi bi-search search-icon position-absolute"></i>
            <input
              id="lar-search"
              type="text"
              className="basic-input"
              name="keyword"
              placeholder="제목, 내용, 닉네임"
              onChange={(e) => setKeyword(e.target.value)}
            />
          </div>
        </div>
        <ul className="ul-list lar">
          {laReviewList.map((laReview) => (
            <li className="text-item" key={laReview.id}>
              <a
                href={`/albums?id=${laReview.albumId}&reviewId=${laReview.id}`}
              >
                <p className="sm-title">{laReview.title}</p>
                <p className="sm-content">{laReview.content}</p>
                <span className="rv-name">{laReview.reviewer.nickname}</span>
                <span className="date">
                  {new Date(laReview.createdAt).toLocaleString()}
                </span>
                <span className="like">❤️ {laReview.likes}</span>
              </a>
            </li>
          ))}
        </ul>
      </div>
    </section>
  )
}

export default LikedAlbumReviewCard