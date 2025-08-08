import React, { useEffect } from 'react'
import MypageTab from './MypageTab'
import { Link, useNavigate } from 'react-router-dom'
import MyPlaylistCard from './card/MyPlaylistCard'
import LikedPlaylistCard from './card/LikedPlaylistCard'

const Playlist = ({likedPlaylists, myPlaylists, lastPath, isOwner, handleLike, handleDelete, handleNavigate}) => {

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