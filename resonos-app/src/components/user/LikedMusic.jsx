import React from 'react'
import MypageTab from './MypageTab'
import LikedAlbumCard from './card/LikedAlbumCard'
import LikedTrackCard from './card/LikedTrackCard'
import LikedAlbumSection from './section/LikedAlbumSection'
import LikedTrackSection from './section/LikedTrackSection'

const LikedMusic = ({countAlbum, countTrack, isOwner, lastPath,likedAlbumList, likedTrackList, userId, setLikedAlbumList, setLikedTrackList, onLikeTrack, onLikeAlbum}) => {

  return (
    <main className="con con-music position-relative">
      {/* 왼쪽 리모컨 */}
      {isOwner && <MypageTab lastPath={lastPath} />}

      {/* 앨범 섹션 */}
      <LikedAlbumSection
        countAlbum={countAlbum}
        likedAlbumList={likedAlbumList}
        isOwner={isOwner}
        setLikedAlbumList={setLikedAlbumList}
        userId={userId}
        onLikeAlbum={onLikeAlbum}
      />

      {/* 트랙 섹션 */}
      <LikedTrackSection
        countTrack={countTrack}
        likedTrackList={likedTrackList}
        isOwner={isOwner}
        setLikedTrackList={setLikedTrackList}
        userId={userId}
        onLikeTrack={onLikeTrack}
      />
    </main>
  )
}

export default LikedMusic