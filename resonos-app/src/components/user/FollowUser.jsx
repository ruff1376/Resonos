import React from 'react'
import MypageTab from './MypageTab'
import FollowerSection from './section/FollowerSection'
import FollowSection from './section/FollowSection'

const FollowUser = ({followCount, followerCount, lastPath, myFollow, myFollower, setMyFollow, setMyFollower, isOwner, userId, onSearchUsers, onFollowUser}) => {

  return (
    <main className={`con con-follow position-relative`}>
      {/* 왼쪽 리모컨 */}
      {isOwner.current && (<MypageTab lastPath={lastPath} />)}

      {/* 팔로워 섹션 */}
      <FollowerSection
        myFollower={myFollower}
        followerCount={followerCount}
        isOwner={isOwner}
        onSearchUsers={onSearchUsers}
        setMyFollower={setMyFollower}
      />

      {/* 팔로우 섹션 */}
      <FollowSection
        myFollow={myFollow}
        followCount={followCount}
        isOwner={isOwner}
        onSearchUsers={onSearchUsers}
        setMyFollow={setMyFollow}
        onFollowUser={onFollowUser}
      />
    </main>
  )
}

export default FollowUser