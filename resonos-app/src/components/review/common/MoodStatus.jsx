import React, { useEffect, useRef } from 'react';
import { Link } from 'react-router-dom';

const MoodStatus = ({ styles, isMoodEmpty, tags, userId, artist, track, userVotedMoodId, moodLabels }) => {
  const chartRef = useRef(null);

  // useEffect(() => {
  //   if (!isMoodEmpty && chartRef.current) {
  //     // 차트 라이브러리를 사용하여 여기에 차트를 그리는 로직을 구현합니다.
  //     // 예: new Chart(chartRef.current, { ... config ... });
  //     console.log("차트 렌더링 로직 실행");
  //   }
  // }, [isMoodEmpty]);

  return (
    <>
      {/* 분위기 */}
      <div className={styles.moodCard}>
        <div className={styles.chart}>
          {/* {isMoodEmpty ? (
            <p id="headline">아직 아무도 분위기에 투표하지 않았어요 😅</p>
          ) : (
            <canvas id="hexRadarChart" ref={chartRef}></canvas>
          )} */}
        </div>
        <div className={styles.moodVote}>
          <div className={styles.voteHeader}>
            <p className={styles.headline}>Mood Tags</p>
          </div>
          <div
            className={styles.moods}
            data-user-id={userId != null ? userId : 0}
            data-artist-id={artist.id}
            data-track-id={track.id}
            id="moodVoteContainer"
          >
            {tags && tags.map(tag => (
              <label
                key={tag.id}
                className={`btn ${styles.btnGold} ${styles.moodOption} ${userVotedMoodId === tag.id ? styles.selected : ''}`}>
                <input
                  type="radio"
                  name="moodVote"
                  value={tag.id}
                  checked={userVotedMoodId === tag.id}
                  hidden
                />
                <span>{tag.name}</span>
              </label>
            ))}
          </div>
          {userId && (
            <button className={`btn ${styles['btn-gold']}`} id="submitMoodVote">
              투표하기
            </button>
          )}
        </div>
        <div className={styles.albumMoods}>
          <p className={styles.headline}>분위기로 노래찾기</p>
          {isMoodEmpty != null && !isMoodEmpty ? (
            <div className={styles.moodList}>
              {moodLabels.map(topMood => (
                <Link
                  key={topMood}
                  to={`/search?q=#${topMood}`}
                  className={`btn ${styles['btn-gold']}`}>
                  {`#${topMood}`}
                </Link>
              ))}
            </div>
          ) : (
            <p style={{ color: 'var(--main-color)' }} id="noVoteMessage">
              아직 아무도 분위기에 투표하지 않았어요 😅
            </p>
          )}
        </div>
      </div>
      {/* 분위기 끝 */}
    </>
  );
};

export default MoodStatus;