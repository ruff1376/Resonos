import React from 'react'
import { Link } from 'react-router-dom'
import {MySwal} from '../../apis/alert'

const UserInfo = ({currentBadge, followCount, followerCount, user, isOwner, countAllReview, alreadyFollow, onFollowUser, onLogout}) => {

  const handleLogout = () => {
    MySwal.fire({
      title: "로그아웃 하시겠습니까?",
      html: '<p class="alert-text">자동 로그인이 해제됩니다.</p>',
      icon: "warning",
      showCancelButton: true,
      confirmButtonText: "확인",
      cancelButtonText: "취소",
      reverseButtons: false,
      customClass: {
      popup: 'follow-popup',
      icon: 'warning-icon',
      title: 'alert-title',
      text: 'alert-text',
      confirmButton: 'alert-button',
      cancelButton: 'alert-cancle-button'
    }
    }).then((result) => {
      if (result.isConfirmed) {
        onLogout()
      }
    })
  }

  return (
    <>
      <section className="profile-section">
      <div className="d-flex flex-column justify-content-center row-gap-4 me-5">
        <img src={user.profileImage} alt="프로필 이미지" className="profile-img" />
        {!isOwner && (
          <button
            id="btn-follow"
            className={`btn-gold ${alreadyFollow ? 'already' : ''}`}
            onClick={() => onFollowUser(user.id, alreadyFollow)}
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
            <Link to="/users/edit" className="mybtn-gold">
              프로필 편집
            </Link>
            <form action="/logout" id="form-logout" method="post">
              <button
                id="btn-logout"
                className="mybtn-outline d-flex justify-content-center"
                type="button"
                onClick={handleLogout}
              >
                로그아웃
              </button>
            </form>
          </div>
        )}
      </div>

      <div className="profile-meta">
        <div>
          <Link to={`/users/${user.id}/follow-users`}>
            <b>팔로워</b>
            <br />
            <span id="follower-count">{followerCount}</span>
          </Link>
        </div>
        <div>
          <Link to={`/users/${user.id}/follow-users`}>
            <b>팔로우</b>
            <br />
            <span id="follow-count">{followCount}</span>
          </Link>
        </div>
        <div>
          <Link to="#">
            <b>리뷰</b>
            <br />
            <span>{countAllReview}</span>
          </Link>
        </div>
      </div>
    </section>
    </>
  )
}

export default UserInfo