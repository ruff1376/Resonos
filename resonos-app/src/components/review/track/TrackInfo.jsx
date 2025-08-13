import React from 'react';
import { Link } from 'react-router-dom';
import InfoScore from '../common/InfoScore';

const TrackInfo = ({ styles, track, album, artist, score, userId, isTrackLikedByUser, trackLikeCount }) => {
  return (
    <>
      {/* 트랙 카드 */}
      <div className={styles.songCard}>
        <div className={styles.songOverall}>
          <div className={styles.songImg}>
            <img src={album.coverImage} alt="" />
            <span className={styles.centerPin}></span>
          </div>
        </div>
        <div className={styles.songInfo}>
          <p className={styles.headline}>{track.title}</p>
          <p>{new Date(album.releaseDate).toLocaleDateString()}</p>
          <Link to={`/artists/${artist.id}`}>
            <p>{artist.name}</p>
          </Link>
          <Link to={`/albums/${album.id}`}>
            <p>{`${album.title}💽의 ${track.trackNo}th track`}</p>
          </Link>
          <div className="review-section">
            <InfoScore score={score} />
          </div>
          <div style={{ display: 'flex', gap: '15px' }}>
            <button
              type="button"
              id="likeTrackBtn"
              className="btn btn-gold"
              data-track-id={track.id}
              data-user-id={userId != null ? userId : 0}
              data-liked={isTrackLikedByUser}
            >
              <span id="likeText">{isTrackLikedByUser ? '좋아요❤️' : '좋아요🤍'}</span>
              <span id="likeCount">{trackLikeCount}</span>
            </button>
            <div className="btn btn-gold" id="addToPlaylistBtn" data-track-id={track.id}>
              저장 💾
            </div>
          </div>
        </div>
      </div>
      {/* 트랙 카드 끝 */}
    </>
  );
};

export default TrackInfo;
