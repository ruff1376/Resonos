import React, { useCallback, useEffect, useRef, useState } from 'react'
import MypageTab from './MypageTab'
import { Link, useNavigate } from 'react-router-dom'
import MyPlaylistCard from './card/MyPlaylistCard'
import LikedPlaylistCard from './card/LikedPlaylistCard'

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

const Playlist = ({likedPlaylists, setLikedPlaylists, myPlaylists, lastPath, isOwner, handleLike, handleDelete, handleNavigate, onSearchPlaylist}) => {

  const [keyword, setKeyword] = useState()
  const debouncedKeyword = useDebounce(keyword, 300)

  const offsetRef = useRef(0);
  const limitRef = useRef(20);
  const loadingRef = useRef(false);
  const allLoadedRef = useRef(false);

  const isFirstRender = useRef(true)

  // 스크롤로 트랙 20개씩 추가 요청
  const handleScroll = useCallback(() => {
    if (loadingRef.current || allLoadedRef.current) return
    const container = document.querySelector('.info-section.lp')
    const nearBottom = container.scrollTop + container.clientHeight >= container.scrollHeight - 150
    if (nearBottom && !loadingRef.current && !allLoadedRef.current) {
      console.log('데이터 요청')
      onSearchPlaylist(debouncedKeyword, offsetRef, limitRef, loadingRef, allLoadedRef, 'ar')
    }
  }, [onSearchPlaylist, debouncedKeyword])

  // 스크롤 함수 추가
  useEffect(() => {
    const container = document.querySelector('.info-section.ar');
    if (!container) return;

    container.addEventListener('scroll', handleScroll);
    return () => {
      const container = document.querySelector('.info-section.ar');
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
    setLikedPlaylists([])

    onSearchPlaylist(debouncedKeyword, offsetRef, limitRef, loadingRef, allLoadedRef, 'ar')
  }, [debouncedKeyword, setLikedPlaylists])

  return (
    <main className="con con-music position-relative">
      {/* 왼쪽 리모컨 */}
      {
        isOwner
        ?
        <MypageTab lastPath={lastPath} />
        :
        <></>
      }
      {/* 내 플레이리스트 */}
      <section className={`info-wrapper ${!isOwner ? "go-center" : ""}`}>
        <div className="info-section">
          <div className="title">
            <div>
              <h2 className="text-start">
                {isOwner ? "내 플레이리스트" : "플레이리스트"}
              </h2>
              <span className="count">{myPlaylists.length}</span>
            </div>
            {isOwner && (
              <Link to="/playlists/new" id="addPli">
                플레이리스트 생성
                <img
                  width="20px"
                  height="20px"
                  src="/img/plus_circle.png"
                  alt="추가버튼"
                />
              </Link>
            )}
          </div>

          {myPlaylists.length === 0 && (
            <div className="empty-text">
              <p>플레이리스트가 없습니다.</p>
            </div>
          )}
          <ul id="myPlaylist" className="ul-list">
            {myPlaylists.map((mpl) =>
              (mpl.isPublic || isOwner) && (
                <MyPlaylistCard
                  mpl={mpl}
                  isOwner={isOwner}
                  onLike={handleLike}
                  onDelete={handleDelete}
                  onNavigate={handleNavigate}
                  key={mpl.id}
                />
              )
            )}
          </ul>
        </div>
      </section>

      {/* 좋아요 한 플레이리스트 */}
      <section className={`info-wrapper ${!isOwner ? "go-center" : ""}`}>
        <div className="info-section lp">
          <div className="title">
            <div>
              <h2 className="text-start">좋아요 한 플레이리스트</h2>
              <span className="count">{likedPlaylists.length}</span>
            </div>
            <div className="text-center position-relative">
              <i className="bi bi-search search-icon position-absolute"></i>
              <input
                id="liked-pli-search"
                type="text"
                className="basic-input"
                name="keyword"
                placeholder="키워드를 입력하세요."
                onChange={e => setKeyword(e.target.value)}
              />
            </div>
          </div>

          {likedPlaylists.length === 0 && (
            <div className="empty-text">
              <p>좋아요 한 플레이리스트가 없습니다.</p>
            </div>
          )}

          <ul className="ul-list liked-pli">
            {likedPlaylists.map((lpl) => (
              <LikedPlaylistCard
                lpl={lpl}
                isOwner={isOwner}
                onLike={handleLike}
                onNavigate={handleNavigate}
                key={lpl.id}
              />
            ))}
          </ul>
        </div>
      </section>
    </main>
  )
}

export default Playlist