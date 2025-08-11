import React, { useCallback, useEffect, useRef, useState } from 'react'
import MypageTab from './MypageTab'
import * as ur from '../../apis/user'
import ArtistCard from './card/ArtistCard'

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

const FollowArtist = ({artistList, setArtistList, count, lastPath, userId, isOwner, onSearchArtist, onFollow}) => {

  const [keyword, setKeyword] = useState('')

  const debouncedKeyword = useDebounce(keyword, 300)

  const offsetRef = useRef(0)
  const limitRef = useRef(20)
  const loadingRef = useRef(false)
  const allLoadedRef = useRef(false)

  const isFirstRender = useRef(true)

  // 스크롤로 트랙 20개씩 추가 요청
  const handleScroll = useCallback(() => {
    if (loadingRef.current || allLoadedRef.current) return
    const container = document.querySelector('.info-section')
    const nearBottom = container.scrollTop + container.clientHeight >= container.scrollHeight - 150
    if (nearBottom && !loadingRef.current && !allLoadedRef.current) {
      console.log('데이터 요청')
      onSearchArtist(debouncedKeyword, offsetRef, limitRef, loadingRef, allLoadedRef)
    }
  }, [onSearchArtist, debouncedKeyword])

  // 스크롤 함수 추가
  useEffect(() => {
    const container = document.querySelector('.info-section')
    if (!container) return

    container.addEventListener('scroll', handleScroll)
    return () => {
      const container = document.querySelector('.info-section')
      if (container) {
        container.removeEventListener('scroll', handleScroll)
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

    if(isFirstRender.current) {
      isFirstRender.current = false
      return
    }

    offsetRef.current = 0
    allLoadedRef.current = false
    setArtistList([])

    onSearchArtist(debouncedKeyword, offsetRef, limitRef, loadingRef, allLoadedRef)
  }, [debouncedKeyword, setArtistList])

  return (
    <main className="con con-follow-art position-relative">
      {/* 왼쪽 리모컨 */}
      {isOwner && <MypageTab lastPath={lastPath} />}

      {/* 팔로워 */}
      <section className={`info-wrapper ${!isOwner ? "go-center" : ""}`}>
        <div className="info-section">
          <div className="title">
            <div>
              <h2 className="text-start">팔로우 아티스트</h2>
              <span className="count">{count}</span>
            </div>
            <div className="text-center position-relative">
              <i className="bi bi-search search-icon position-absolute"></i>
              <input
                id="artist-search"
                type="text"
                className="basic-input"
                name="keyword"
                placeholder="키워드를 입력하세요."
                value={keyword}
                onChange={e => setKeyword(e.target.value)}
              />
            </div>
          </div>

          <ul className="ul-list">
            {!artistList || artistList.length === 0
            ? (
              <div className="empty-text">
                <p>팔로우 한 아티스트가 없습니다.</p>
              </div>
            )
            : (
              artistList.map((artist) => (
                <ArtistCard
                  key={artist.id}
                  onFollow={onFollow}
                  artist={artist}
                  isOwner={isOwner}
                />
              ))
            )}
          </ul>
        </div>
      </section>
    </main>
  )
}

export default FollowArtist