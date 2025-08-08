import React, { useEffect, useState } from 'react'

const UserEditForm = ({badgeList, badgeName, user, onSubmit, result, success}) => {

  console.log(success)

  const [profileImage, setProfileImage] = useState()
  const [profileImg, setProfileImg] = useState()
  const [nickname, setNickname] = useState()
  const [email, setEmail] = useState()
  const [bio, setBio] = useState()
  const [currentBadge, setCurrentBadge] = useState()

  const handleSubmit = (e) => {
    e.preventDefault()
    const formData = new FormData()
    formData.append('profileImage', profileImage)
    formData.append('nickname', nickname)
    formData.append('email', email)
    formData.append('bio', bio)
    formData.append('currentBadge', currentBadge)
    formData.append('profileImg', profileImg)

    onSubmit(formData)
  }

  // 배지 변경 함수
  const changeBadge = (e) => {
    const id = e.currentTarget.querySelector('input[type="hidden"]').value
    const element = document.querySelector('.current.badge')

    if(currentBadge == id) {
      console.log('취소')
      setCurrentBadge(0)
      element.innerText = ''
    } else {
      console.log('변경')
      setCurrentBadge(id)
      element.innerText = e.currentTarget.querySelector('.badge-name').innerText
    }
  }

  useEffect(() => {
    if (user) {
      setProfileImage(user.profileImage || '')
      setNickname(user.nickname || '')
      setEmail(user.email || '')
      setBio(user.bio || '')
      setCurrentBadge(user.currentBadge || '')
    }
  }, [user])

  useEffect(() => {
    document.getElementById('profileImg').addEventListener('change', function (event) {
      const file = event.target.files[0];
      const preview = document.querySelector('.profile-img.edit');

      if (file) {
        const reader = new FileReader()
        reader.onload = function (e) {
          preview.src = e.target.result
          setProfileImg(file)
          console.log(profileImg)
        };
        reader.readAsDataURL(file);
      } else {
        preview.src = ''
      }
    });
  }, [])

  return (
    <div className="con edit d-flex justify-content-center">
      <form
        onSubmit={handleSubmit}
        className="profile-edit-box"
        encType="multipart/form-data"
      >
        {success != null && (
          <p
            className={`success-fail${success === false ? ' error' : ''}`}
          >
            {success === false
              ? '업데이트 실패하였습니다.'
              : '업데이트 완료되었습니다.'}
          </p>
        )}
        <h3>프로필 편집</h3>

        <label id="profileBtn" htmlFor="profileImg">
          <img src={user.profileImage} alt="프로필 이미지" className="profile-img edit" />
          <input
            type="file"
            id="profileImg"
            name="profileImg"
          />
        </label>

        <p className="my-5">
          <span className="current badge">
            {badgeName || ''}
          </span>
          <input type="hidden" name="currentBadge" value={currentBadge} />
        </p>

        <div className="input-area">
          <p className="profile-edit-label">보유 배지</p>
          <div className="change-edge">
            <div>
              {badgeList.map((badge) => (
                <div className="bg-badge" key={badge.id} onClick={e => changeBadge(e)}>
                  <input type="hidden" value={badge.id}/>
                  <div className="badge">
                    <span className="badge-name">{badge.name}</span>
                  </div>
                  <p>{badge.description}</p>
                </div>
              ))}
            </div>
          </div>

          <label className="profile-edit-label" htmlFor="nickname">닉네임</label>
          <input
            type="text"
            className="form-control"
            id="nickname"
            value={nickname}
            onChange={(e) => setNickname(e.target.value)}
          />
          <p className="fail-vali text-start">
            {result.nickError && '숫자만을 제외한 조합, 특수문자 제외 2 ~ 10글자 사이여야 합니다.'}
            {result.nickDuple && '사용중인 닉네임입니다.'}
          </p>

          <label className="profile-edit-label" htmlFor="email">이메일</label>
          <input
            type="email"
            className="form-control"
            id="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
          <p className="fail-vali text-start">
            {result.emailError && '유효한 형식의 이메일을 입력해주세요.'}
            {result.emailDuple && '사용중인 이메일입니다.'}
          </p>

          <label className="profile-edit-label" htmlFor="bio">자기소개</label>
          <textarea
            className="form-control"
            id="bio"
            rows="2"
            value={bio}
            onChange={(e) => setBio(e.target.value)}
            placeholder="자기소개를 입력하세요."
          >
          </textarea>
        </div>

        <div className="btn-area">
          <button className="btn btn-gold" type="submit">정보 수정</button>
          <a href="/users/mypage" className="btn btn-outline-gold">마이페이지</a>
        </div>
      </form>
    </div>
  )
}

export default UserEditForm