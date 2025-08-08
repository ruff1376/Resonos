import React, { useEffect } from 'react'
import DoughnutChart from './DoughnutChart'
import { Link } from 'react-router-dom'

const UserResource = ({albumList, artistList, badgeList, chartData, playlists, trackList, utl, user, isOwner, countAllReview}) => {


  useEffect(() => {

  }, [])

  return (
    <>
      <div className="my-middle">
        {/* 플레이리스트 */}
        <Link to={`/users/${user.id}/playlists`}>
          <div className="mypage-card playlist">
            <h3>{isOwner ? '내 플레이리스트' : '플레이리스트'}</h3>
            {(playlists == null || playlists.length === 0) ? (
              <div className="empty-text">
                <p>플레이리스트가 없습니다.</p>
                {isOwner && <p>만들러 가기 ➡️</p>}
              </div>
            ) : (
              <ul>
                {playlists.map(pl => (
                  <li key={pl.id}>
                    <div className="w-75 d-flex align-items-center">
                      <img className="cover-img" width="50" height="50" src={pl.thumbnailUrl} alt="커버이미지" />
                      <span className="pli-name">{pl.title}</span>
                    </div>
                    <div className="like-count">
                      <span>{pl.likeCount}</span>
                      <span className="like">♥</span>
                    </div>
                  </li>
                ))}
              </ul>
            )}
          </div>
        </Link>

        <div className="chart-area">
          <h3>선호하는 장르</h3>
          <DoughnutChart chartData={chartData} />
        </div>
      </div>

      <section className="mypage-grid">
        {/* 좋아요 한 앨범 */}
        <a className="grid-item" href={`/users/${user.id}/liked-music`}>
          <div className="mypage-card album">
            <h3>좋아요 한 앨범</h3>
            {(albumList == null || albumList.length === 0) ? (
              <div className="empty-text">
                <p>좋아요 한 앨범이 없습니다.</p>
              </div>
            ) : (
              <ul>
                {albumList.map(album => (
                  <li key={album.id}>
                    <img width="50" height="50" src={album.coverImage} alt="커버이미지" />
                    <p>{album.title}</p>
                  </li>
                ))}
              </ul>
            )}
          </div>
        </a>

        {/* 좋아요 한 트랙 */}
        <a className="grid-item" href={`/users/${user.id}/liked-music`}>
          <div className="mypage-card track">
            <h3>좋아요 한 트랙</h3>
            {(trackList == null || trackList.length === 0) ? (
              <div className="empty-text">
                <p>좋아요 한 트랙 없습니다.</p>
              </div>
            ) : (
              <ul>
                {trackList.map(track => (
                  <li key={track.id}>
                    <img width="50" height="50" src={track.coverImage} alt="커버이미지" />
                    <p>{track.title}</p>
                  </li>
                ))}
              </ul>
            )}
          </div>
        </a>

        {/* 팔로우 한 아티스트 */}
        <a className="grid-item" href={`/users/${user.id}/follow-artist`}>
          <div className="mypage-card artist">
            <h3>팔로우 아티스트</h3>
            {(artistList == null || artistList.length === 0) ? (
              <div className="empty-text">
                <p>팔로우 한 아티스트가 없습니다.</p>
              </div>
            ) : (
              <ul>
                {artistList.map(artist => (
                  <li key={artist.id}>
                    <img width="50" height="50" src={artist.profileImage} alt="커버이미지" />
                    <p>{artist.name}</p>
                  </li>
                ))}
              </ul>
            )}
          </div>
        </a>

        {/* 내 활동 (isOwner일 때만) */}
        {isOwner && (
          <a className="grid-item" href="/users/activity">
            <div className="mypage-card activate">
              <h3>내 활동</h3>
              <ul>
                <li>
                  <h4>작성 리뷰</h4>
                  <p>{countAllReview}</p>
                </li>
                <li>
                  <h4>받은 좋아요</h4>
                  <p>{utl?.totalLikes ?? 0}</p>
                </li>
              </ul>
            </div>
          </a>
        )}

        {/* 배지 (isOwner일 때만) */}
        {isOwner && (
          <a className="grid-item" href="/users/badge">
            <div className="mypage-card badge-area">
              <h3>배지</h3>
              <h4>최근 획득한 배지</h4>
              {(badgeList == null || badgeList.length === 0) ? (
                <div className="empty-text">
                  <p>최근 획득한 배지가 없습니다.</p>
                </div>
              ) : (
                <ul>
                  {badgeList.map(badge => (
                    <li key={badge.id}>
                      <span className="badge">{badge.name}</span>
                    </li>
                  ))}
                </ul>
              )}
            </div>
          </a>
        )}

        {/* 계정 / 보안 (isOwner일 때만) */}
        {isOwner && (
          <a className="grid-item" href="/users/security">
            <div className="mypage-card security">
              <h3>계정 / 보안</h3>
              <ul>
                <li>이메일: <span>{user.email}</span></li>
                <li className="impor">
                  <span>비밀번호 변경</span>&nbsp;/&nbsp;<span>탈퇴</span>
                </li>
              </ul>
            </div>
          </a>
        )}
      </section>
    </>
  )
}

export default UserResource