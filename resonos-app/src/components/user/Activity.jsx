import React, { useCallback } from 'react'
import MypageTab from './MypageTab'
import AlbumReviewCard from './card/AlbumReviewCard'
import LikedAlbumReviewCard from './card/LikedAlbumReviewCard'
import TrackReviewCard from './card/TrackReviewCard'
import LikedTrackReviewCard from './card/LikedTrackReviewCard'

const Activity = ({utl, countAReview, aReviewList, countLaReview, laReviewList, countTReview, tReviewList, countLtReview, ltReviewList, lastPath, onSearchReview, setAReviewList, setLaReviewList, setLtReviewList, setTReviewList}) => {

  return (
    <main className="con con-activity position-relative">
      {/* 왼쪽 리모컨 */}
      <MypageTab lastPath={lastPath}/>

      {/* 통계 */}
      <section className="mypage-grid">
        <div className="grid-item">
          <div className="mypage-card">
            <h3>받은 좋아요 (앨범)</h3>
            <span className="count">{utl.albumLikes}</span>
          </div>
        </div>
        <div className="grid-item">
          <div className="mypage-card">
            <h3>받은 좋아요 (트랙)</h3>
            <span className="count">{utl.trackLikes}</span>
          </div>
        </div>
      </section>

      {/* 내가 쓴 앨범 리뷰 */}
      <AlbumReviewCard
        countAReview={countAReview}
        aReviewList={aReviewList}
        onSearchReview={onSearchReview}
        setAReviewList={setAReviewList}
      />

      {/* 좋아요 한 앨범 리뷰 */}
      <LikedAlbumReviewCard
        countLaReview={countLaReview}
        laReviewList={laReviewList}
        onSearchReview={onSearchReview}
        setLaReviewList={setLaReviewList}
      />

      {/* 내가 쓴 트랙 리뷰 */}
      <TrackReviewCard
        countTReview={countTReview}
        tReviewList={tReviewList}
        onSearchReview={onSearchReview}
        setTReviewList={setTReviewList}
      />

      {/* 좋아요 한 트랙 리뷰 */}
      <LikedTrackReviewCard
        countLtReview={countLtReview}
        ltReviewList={ltReviewList}
        onSearchReview={onSearchReview}
        setLtReviewList={setLtReviewList}
      />
    </main>
  )
}

export default Activity