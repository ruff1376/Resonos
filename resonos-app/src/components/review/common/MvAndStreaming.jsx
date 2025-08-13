import React from 'react'

const MvAndStreaming = ({ styles, tracks, track }) => {
  return (
    <>
      {/* 유튭, 스포티파이 아이프레임 */}
      <div className={styles.iframeCard}>
        <div className={styles.spotify}>
        {tracks != null && tracks.length > 0 ? (
          <iframe
            src={`https://open.spotify.com/embed/track/${tracks[0].id}?utm_source=generator`}
            width="100%"
            height="352"
            frameBorder="0"
            allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture"
            loading="lazy"
          ></iframe>
        ) : (
        <iframe
          src={`https://open.spotify.com/embed/track/${track.id}?utm_source=generator`}
          width="100%"
          height="352"
          frameBorder="0"
          allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture"
          loading="lazy"
        ></iframe>
        )}
        </div>
        <div className={styles.youtube}>
          {track.mvUrl ? (
            <div id="video-container" data-video-id={track.mvUrl}>
              <iframe
                id="yt-frame"
                width="560"
                height="315"
                src={`https://www.youtube.com/embed/${track.mvUrl}`}
                title="YouTube video player"
                frameBorder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowFullScreen
              ></iframe>
            </div>
          ) : (
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
      {/* 아이프레임 끝 */}
    </>
  )
}

export default MvAndStreaming