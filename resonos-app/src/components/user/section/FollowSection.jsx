import React, { useCallback, useEffect, useRef, useState } from 'react'
import FollowCard from '../card/FollowCard'

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

const FollowSection = ({myFollow, isOwner, followCount, onSearchUsers,
setMyFollow, onFollowUser}) => {

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
    const container = document.querySelector('.info-section.follow')
    const nearBottom = container.scrollTop + container.clientHeight >= container.scrollHeight - 150
    if (nearBottom && !loadingRef.current && !allLoadedRef.current) {
      console.log('데이터 요청')
      onSearchUsers(debouncedKeyword, offsetRef, limitRef, loadingRef, allLoadedRef, 'follow')
    }
  }, [onSearchUsers, debouncedKeyword])

  // 스크롤 함수 추가
  useEffect(() => {
    const container = document.querySelector('.info-section.follow');
    if (!container) return;

    container.addEventListener('scroll', handleScroll);
    return () => {
      const container = document.querySelector('.info-section.follow');
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
    setMyFollow([])

    onSearchUsers(debouncedKeyword, offsetRef, limitRef, loadingRef, allLoadedRef, 'follow')
  }, [debouncedKeyword, setMyFollow])

  return (
    <section className={`info-wrapper ${!isOwner ? 'go-center' : ''}`}>
      <div className="info-section follow">
        <div className="title">
          <div>
            <h2 className="text-start">팔로우</h2>
            <span className="count">{followCount}</span>
          </div>
          <div className="text-center position-relative">
            <i className="bi bi-search search-icon position-absolute"></i>
            <input
              id="follow-search"
              type="text"
              className="basic-input follow"
              name="keyword"
              placeholder="키워드를 입력하세요."
              onChange={e => setKeyword(e.target.value)}
            />
          </div>
        </div>
        <ul className="ul-list follow">
          {(!myFollow || myFollow.length === 0) && (
            <p className="empty-text">팔로우한 회원이 없습니다.</p>
          )}
          {myFollow &&
            myFollow.map((follow) => (
              <FollowCard
                key={follow.id}
                follow={follow}
                isOwner={isOwner}
                onFollowUser={onFollowUser}
              />
            ))}
        </ul>
      </div>
    </section>
  )
}

export default FollowSection