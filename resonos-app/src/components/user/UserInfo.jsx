import React from 'react'

const UserInfo = ({
  user,
  isOwner,
  alreadyFollow,
  currentBadge,
  followerCount,
  followCount,
  countAllReview,
  onFollowToggle
}) => {
  return (
    <>
      <section className="profile-section">
      <div className="d-flex flex-column justify-content-center row-gap-4 me-5">
        <img src={user.profileImage} alt="프로필 이미지" className="profile-img" />
        {!isOwner && (
          <button
            id="btn-follow"
            className={`btn-gold ${alreadyFollow ? 'already' : ''}`}
            onClick={onFollowToggle}
          >
            {alreadyFollow ? '언팔로우' : '팔로우'}
          </button>
        )}
      </div>

      <div className="profile-info">
        <div className="info-top">
          <h2>{user.nickname}</h2>
          {currentBadge !== '' && <span className="badge">{currentBadge}</span>}
        </div>
        <p id="bio">{user.bio}</p>

        {isOwner && (
          <div className="profile-actions">
            <a href="/users/edit" className="mybtn-gold">
              프로필 편집
            </a>
            <form action="/logout" id="form-logout" method="post">
              <button
                id="btn-logout"
                className="mybtn-outline d-flex justify-content-center"
                type="submit"
              >
                로그아웃
              </button>
            </form>
          </div>
        )}
      </div>

      <div className="profile-meta">
        <div>
          <a href={`/users/${user.id}/follow-user`}>
            <b>팔로워</b>
            <br />
            <span id="follower-count">{followerCount}</span>
          </a>
        </div>
        <div>
          <a href={`/users/${user.id}/follow-user`}>
            <b>팔로우</b>
            <br />
            <span id="follow-count">{followCount}</span>
          </a>
        </div>
        <div>
          <a href="#">
            <b>리뷰</b>
            <br />
            <span>{countAllReview}</span>
          </a>
        </div>
      </div>
    </section>
    </>
  )
}

export default UserInfo