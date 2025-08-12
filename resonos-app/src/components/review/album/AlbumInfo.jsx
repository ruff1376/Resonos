import React from 'react'
import { Link } from 'react-router-dom'
import InfoScore from '../common/InfoScore'


const AlbumInfo = ({ score, handleLikeClick,isAlbumLikedByUser, albumLikeCount, userId, styles, album, artist, tracks }) => {
  console.log(tracks)
  return (
    <>
      {/* 앨범 카드 */}
      <div className={styles.songCard}>
        <div className={styles.songOverall}>
          <div className={styles.songImg}>
            <img src={album.coverImage} alt={album.title} />
            <span className={styles.centerPin}></span>
          </div>
        </div>
        <div className={styles.songInfo}>
          <p className={styles.headline}>{album.title}</p>
          <p>{album.releaseDate}</p>
          <Link to={`/artists?id=${artist.id}`}>
            <p>{artist.name}</p>
          </Link>
          <p>{album.label}</p>
          <div className={styles.reviewSection}>
            <InfoScore styles={styles} score={score} />
          </div>
          <div style={{ display: 'flex', gap: '15px' }}>
            <button
              type="button"
              className={`${styles.btn} ${styles.btnGold} ${styles.likeAlbumBtn}`}
              data-album-id={album.id}
              data-liked={isAlbumLikedByUser}
              onClick={() => handleLikeClick(userId, album)}
            >
              <span className={styles.likeText}>{isAlbumLikedByUser ? '좋아요❤️' : '좋아요🤍'}</span>
              <span className={styles.likeCount}>{albumLikeCount}</span>
            </button>
          </div>
        </div>
        {/* 트랙리스트 */}
        {album && tracks && tracks.length > 0 && (
          <div className={styles.trackGraphy}>
            <div className={styles.trackHeader}>
              <p className={styles.headline}>{`${album.title}💽 Tracks`}</p>
            </div>
            <div className={styles.trackContainer}>
              {tracks.map((track) => (
                <Link key={track.id} to={`/tracks?id=${track.id}`}>
                  <div className={styles.track}>
                    <div className={styles.trackImg}>
                      <img src={album.coverImage} alt={track.title} />
                      <span className={styles.centerPin}></span>
                    </div>
                    <div className={styles.trackInfo}>
                      <p id="subtitle">{track.title}</p>
                      <p>{track.formattedDuration}</p>
                      <p>{`${track.trackNo}th Track`}</p>
                    </div>
                  </div>
                </Link>
              ))}
            </div>
          </div>
        )}
      </div>
      {/* 앨범카드 끝 */}
    </>
  )
}

export default AlbumInfo