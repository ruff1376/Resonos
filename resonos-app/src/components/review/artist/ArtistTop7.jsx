import React from 'react';
import { Link } from 'react-router-dom';

const ArtistTop7 = ({  styles, artist, top7Tracks, track }) => {

  if(!artist || !top7Tracks || !track) {
    return null
  }

  return (
    <>
      <div className={styles.hottestCard}>
        <div className={styles.songs}>
          <p className={styles.headline}>{`${artist.name}'s 🔥TOP ${top7Tracks ? top7Tracks.length : 0}`}</p>
          {/* 반복문 인기곡 */}
          {top7Tracks && top7Tracks.map((tops, index) => (
            <Link key={tops.id} to={`/tracks/${tops.id}`}>
              <p>{`${index + 1}. ${tops.title}  `}</p>
              <span>{tops.formattedDuration}</span>
            </Link>
          ))}
        </div>
        <div className={styles.youtube}>
          {/* 유효한 mvUrl인 경우 */}
          {track.mvUrl && track.mvUrl !== 'N/A' ? (
            <div id="video-container" data-video-id={track.mvUrl}>
              <iframe
                id="yt-frame"
                width="560"
                height="315"
                src={`https://www.youtube.com/embed/${track.mvUrl}`}
                title="YouTube video player"
                frameBorder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
              ></iframe>
            </div>
          ) : (
            /* mvUrl이 없거나 N/A일 때 */
            <img
              src="/img/wait_plz.png"
              alt="뮤직비디오 준비중"
              width="560"
              height="315"
              style={{ objectFit: 'cover' }}
            />
          )}
        </div>
      </div>
    </>
  );
};

export default ArtistTop7;
