import React, { useCallback, useEffect, useRef, useState } from 'react'
import FollowerCard from '../card/FollowerCard'

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

const FollowerSection = ({myFollower, isOwner, followerCount, onSearchUsers, setMyFollower}) => {

  const [keyword, setKeyword] = useState('')
  const debouncedKeyword = useDebounce(keyword, 300)

  const offsetRef = useRef(0);
  const limitRef = useRef(20);
  const loadingRef = useRef(false);
  const allLoadedRef = useRef(false);

  const isFirstRender = useRef(true)

  // 스크롤로 트랙 20개씩 추가 요청
  const handleScroll = useCallback(() => {
    if (loadingRef.current || allLoadedRef.current) return
    const container = document.querySelector('.info-section.follower')
    const nearBottom = container.scrollTop + container.clientHeight >= container.scrollHeight - 150
    if (nearBottom && !loadingRef.current && !allLoadedRef.current) {
      console.log('데이터 요청')
      onSearchUsers(debouncedKeyword, offsetRef, limitRef, loadingRef, allLoadedRef, 'follower')
    }
  }, [onSearchUsers, debouncedKeyword])

  // 스크롤 함수 추가
  useEffect(() => {
    const container = document.querySelector('.info-section.follower');
    if (!container) return;

    container.addEventListener('scroll', handleScroll);
    return () => {
      const container = document.querySelector('.info-section.follower');
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

    if(isFirstRender.current) {
      isFirstRender.current = false
      return
    }

    offsetRef.current = 0
    allLoadedRef.current = false
    setMyFollower([])

    onSearchUsers(debouncedKeyword, offsetRef, limitRef, loadingRef, allLoadedRef, 'follower')
  }, [debouncedKeyword, setMyFollower])

  return (
    <section className={`info-wrapper ${!isOwner ? 'go-center' : ''}`}>
      <div className="info-section follower">
        <div className="title">
          <div>
            <h2 className="text-start">팔로워</h2>
            <span className="count">{followerCount}</span>
          </div>
          <div className="text-center position-relative">
            <i className="bi bi-search search-icon position-absolute"></i>
            <input
              id="follower-search"
              type="text"
              className="basic-input follower"
              name="keyword"
              placeholder="키워드를 입력하세요."
              onChange={e => setKeyword(e.target.value)}
            />
          </div>
        </div>
        <ul className="ul-list follower">
          {(!myFollower || myFollower.length === 0) && (
            <p className="empty-text">팔로워가 없습니다.</p>
          )}
          {myFollower &&
            myFollower.map((follower) => (
              <FollowerCard
                key={follower.id}
                follower={follower}
              />
            ))}
        </ul>
      </div>
    </section>
  )
}

export default FollowerSection