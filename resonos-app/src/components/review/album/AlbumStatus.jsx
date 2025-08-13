import React from 'react'
import { Link } from 'react-router-dom'

const AlbumStatus = ({styles, album, top5List, isArgEmpty, argValues, emptyPlayList, playLists}) => {
  return (
    <>
      {/* 앨범 트랙리스트 분위기 뭐뭐.. */}
      <div className={styles.infoCard}>
        <div className={`${styles.info} ${styles.top5track}`}>
          <p className={styles.headline}>{`${album.title}💽 TOP${top5List.length}🔥`}</p>
          {top5List.map((tops, index) => (
            <Link key={tops.id} to={`/tracks?id=${tops.id}`}>
              <div className="d-flex gap-3" style={{ maxHeight: 'fit-content' }}>
                <p
                  style={{
                    maxWidth: '300px',
                    whiteSpace: 'nowrap',
                    overflow: 'hidden',
                    textOverflow: 'ellipsis',
                  }}
                >
                  {`${index + 1}. ${tops.title}`}
                </p>
                <span>{tops.formattedDuration}</span>
              </div>
            </Link>
          ))}
        </div>

        <div className={`${styles.info} ${styles.albumMoods}`}>
          <p className={styles.headline}>앨범의 평균 점수</p>
          {isArgEmpty ? (
            <p>아직 아무도 투표하지 않았어요</p>
          ) : (
            <div className={styles.scoreInfo}>
              {argValues && Object.entries(argValues).map((label,score) => (
                <div key={label}>
                  <span>{label} : </span>
                  <span>{score}점</span>
                </div>
              ))}
            </div>
          )}
        </div>
        <div className="info pl-list">
          <p className={styles.headline}>{`${album.title}💽의 트랙이 포함된 플리🎶`}</p>
          {emptyPlayList || playLists.length === 0 ? (
            <>
              <p>해당 음원을 포함한</p>
              <p>플레이리스트를 만들어보세요! 🤩</p>
            </>
          ) : (
            playLists.map((playList) => (
              <Link key={playList.id} to={`/playlists/${playList.id}`}>
                <p>{`${playList.title} ❤️${playList.likeCount}`}</p>
              </Link>
            ))
          )}
        </div>
      </div>
      {/* 앨범 트랙리스트 분위기 뭐뭐.. 끝 */}
    </>
  )
}

export default AlbumStatus