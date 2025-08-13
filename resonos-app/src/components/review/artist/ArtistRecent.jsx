import React, { useEffect } from 'react';
import { Link } from 'react-router-dom';
import BandsintownWidget from './BandsInTown';

const ArtistRecent = ({ styles, artist, recentReviews }) => {

  useEffect(() => {
    // artistName이 유효해지고, Bandsintown 스크립트가 로드되었을 때
    if (artist.name && window.Bandsintown) {
      // 위젯 초기화 함수를 호출
      window.Bandsintown.init();
    }
  }, [artist.name]); // artistName이 변경되면 재실행

  // artistName이 유효할 때만 위젯 div 렌더링
  if (!artist.name) {
    return null;
  }

  
  return (
    <>
      <div className={styles.infoCard}>
        <div className={`${styles.info} ${styles.recentReview}`}>
          <p className={styles.headline}>{`${artist.name} 최근 리뷰`}</p>
          {recentReviews == null || recentReviews.length === 0 ? (
            <p className={styles.headline}>아직 리뷰가 없어요</p>
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
          <p className={styles.headline}>공연/이벤트 일정</p>
          {artist && artist.name && (
            <BandsintownWidget artistName={artist.name} />
          )}
        </div>
      </div>
    </>
  );
};

export default ArtistRecent;
