import React from 'react'
import MypageTab from './MypageTab'
import { Link } from 'react-router-dom'

const Playlist = ({likedPlaylists, myPlaylists, lastPath, isOwner}) => {
  return (
    <main className="con con-music position-relative">
      {/* 왼쪽 리모컨 */}
      {
        isOwner
        ?
        <MypageTab />
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
                <li className="list-item" key={mpl.id}>
                  <input type="hidden" value={mpl.id} name="id" />
                  <img
                    src={mpl.thumbnailUrl}
                    alt="GalaxiNote"
                    className="follow-img"
                  />
                  <div className="info">
                    <span className="name-playlist">{mpl.title}</span>
                  </div>
                  {isOwner && (
                    <span className="is-public">
                      {mpl.isPublic ? "공개" : "비공개"}
                    </span>
                  )}
                  <div className="right">
                    <div className="like-area">
                      <span className="like">♥</span>
                      <span className="count">{mpl.likeCount}</span>
                    </div>
                    {isOwner && (
                      <button className="btn btn-danger">삭제</button>
                    )}
                  </div>
                </li>
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
              <li className="list-item" key={lpl.id}>
                <input type="hidden" value={lpl.id} name="id" />
                <img
                  src={lpl.thumbnailUrl}
                  className="follow-img"
                  alt={lpl.title}
                />
                <div className="info">
                  <span className="name-album">{lpl.title}</span>
                  <span className="name-user">{lpl.ownerName}</span>
                </div>
                {isOwner && (
                  <button className="like like-button already">♥</button>
                )}
              </li>
            ))}
          </ul>
        </div>
      </section>
    </main>
  )
}

export default Playlist