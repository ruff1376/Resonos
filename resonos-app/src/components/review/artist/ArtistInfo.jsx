import React from 'react';
import { Link } from 'react-router-dom';

const ArtistInfo = ({ styles, artist, albumCount, trackCount, userId, isArtistFollowed, followCount, albums }) => {

  return (
    <>
      <div className={styles.artistCard}>
        <div className={styles.artistOverall}>
          <div className={styles.artistImg}>
            <img src={artist?.profileImage || ''} alt="" />
          </div>
          <div className={styles.artistInfo}>
            <p className={styles.headline}>{artist.name}</p>
            <p>{`💽앨범 : ${albumCount}`}</p>
            <p>{`🎶곡 : ${trackCount}`}</p>
            <div style={{ display: 'flex', gap: '15px' }}>
              <button
                type="button"
                id="followArtistBtn"
                className={`btn ${styles['btn-gold']}`}
                data-artist-id={artist.id}
                data-user-id={userId ? userId : 0}
                data-followed={isArtistFollowed}
              >
                <span id="followText">
                  {isArtistFollowed ? '팔로우❤️' : '팔로우🤍'}
                </span>
                <span id="followCount">{followCount}</span>
              </button>
            </div>
          </div>
        </div>
        <div className={styles.discoGraphy}>
          <div className={styles.graphyHeader}>
            <p className={styles.headline}>디스코 그래피</p>
          </div>
          <div className={styles.albumContainer}>
            {/* 반복문 구간 */}
            {albums && albums.map((album) => (
              <Link key={album.id} to={`/albums?id=${album.id}`}>
                <div className={styles.album}>
                  <div className={styles.albumImg}>
                    <img src={album.coverImage} alt="" />
                    <span className="center-pin"></span>
                  </div>
                  <div className={styles.albumInfo}>
                    <p className={styles.subtitle}>{album.title}</p>
                    <p>{new Date(album.releaseDate).toLocaleDateString()}</p>
                    <p>{album.label}</p>
                  </div>
                </div>
              </Link>
            ))}
          </div>
        </div>
      </div>
    </>
  );
};

export default ArtistInfo;