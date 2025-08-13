import React, { useEffect } from 'react';
import { Link } from 'react-router-dom';

const ArtistRecent = ({ styles, artist, recentReviews }) => {


  if(!artist || !recentReviews) {
    return null
  }


  useEffect(() => {
    // 스크립트가 이미 로드되었는지 확인하는 로직 추가
    if (document.getElementById('bandsintown-widget-script')) {
      return;
    }

    const script = document.createElement('script');
    script.src = "//widget.bandsintown.com/v1.0/widgets.js";
    script.async = true;
    script.id = "bandsintown-widget-script";
    document.body.appendChild(script);

    // 컴포넌트 언마운트 시 스크립트 제거
    return () => {
      document.body.removeChild(script);
    };
  }, []);

  return (
    <>
      <div className={styles.infoCard}>
        <div className={`${styles.info} ${styles.recentReview}`}>
          <p id="headline">{`${artist.name} 최근 리뷰`}</p>
          {recentReviews == null || recentReviews.length === 0 ? (
            <p id="headline">아직 리뷰가 없어요</p>
          ) : (
            recentReviews.map((review) => (
              <Link
                key={review.id} // Assuming review.id is unique
                to={review.type === 'TRACK' ? `/tracks?id=${review.id}` : `/albums?id=${review.id}`}
                className={styles.reviewLine}
              >
                <span className={styles.reviewIcon}>
                  {review.type === 'TRACK' ? '[🎵]' : '[💽]'}
                </span>
                <strong className={styles.reviewTitle}>{review.name}</strong>
                <span className={styles.reviewContent}>{review.content}</span>
                <span className={`${styles.reviewBox} ${styles.reviewRating}`}>
                  {`🔮 ${review.rating}`}
                </span>
                <span className={styles.reviewBox}>
                  {new Date(review.createdAt).toLocaleString('ko-KR', {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                  })}
                </span>
              </Link>
            ))
          )}
        </div>
        <div className={`${styles.info} ${styles.concertSchedule}`}>
          <p id="headline">공연/이벤트 일정</p>
          <div
            className="bit-widget-initializer"
            data-artist-name={artist.name}
            data-text-color="#FFF"
            data-background-color="transparent"
            data-display-local-dates="true"
            data-auto-style="true"
            data-separator-color="#DDDDDD"
            data-link-color="#1DB954"
            data-display-limit="3"
            data-display-lineup="false"
            data-display-play-my-city="false"
          ></div>
        </div>
      </div>
    </>
  );
};

export default ArtistRecent;
