import React, { useEffect, useState } from 'react'
import MypageTab from './MypageTab'
import {MySwal} from '../../apis/alert'

const Security = ({provider, lastPath, vali, error, onCheckPassword, onChangePassword, setError, brError, onWithdrawal }) => {


  const [password, setPassword] = useState("");
  const [password2, setPassword2] = useState("");

  const handleWithdrawal = () => {
    MySwal.fire({
      title: "정말 탈퇴하시겠습니까?",
      html: '<p class="alert-text">회원탈퇴한 계정 정보는 복구가 어렵습니다😥</p>',
      icon: "warning",
      showCancelButton: true,
      confirmButtonText: "예",
      cancelButtonText: "아니오",
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
        onWithdrawal()
      }
    })
  }

  useEffect(() => {
    if(password != password2) {
      setError('비밀번호가 일치하지 않습니다.')
    } else {
      setError('')
    }
  }, [password2])

  return (
    <main className="con con-security position-relative">
      <MypageTab lastPath={lastPath} />

      <section className="info-wrapper">
        <div className="info-section">
          <div className="title">
            <div>
              <h2 className="text-start">계정 / 보안</h2>
            </div>
            {(vali || provider) && (
              <button type="button" id="btn-withdrawal" onClick={handleWithdrawal}>
                회원탈퇴
              </button>
            )}
          </div>

          <div className="inner">
            <p className="text-start mb-5">연동된 SNS : {provider || "없음"}</p>

            {/* 비밀번호 확인 폼 */}
            {!vali && !provider && (
              <form onSubmit={e => onCheckPassword(e, password)}>
                <div className="input-area">
                  <label className="profile-edit-label" htmlFor="password">
                    비밀번호
                  </label>
                  <input
                    name="password"
                    id="password"
                    type="password"
                    className="form-control"
                    placeholder="비밀번호를 입력해주세요."
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                  />
                  {error && <p className="fail-vali text-start">{error}</p>}
                </div>
                <div className="btn-area">
                  <button className="btn btn-gold" type="submit">
                    확인
                  </button>
                </div>
              </form>
            )}

            {/* 비밀번호 변경 폼 */}
            {vali && (
              <form onSubmit={e => onChangePassword(e, password, password2)}>
                <div className="input-area">
                  <label className="profile-edit-label" htmlFor="password">
                    변경할 비밀번호
                  </label>
                  <input
                    type="password"
                    className="form-control"
                    id="password"
                    name="password"
                    onChange={(e) => setPassword(e.target.value)}
                  />
                  {brError && <p className="fail-vali text-start">{brError}</p>}
                  <label className="profile-edit-label" htmlFor="password2">
                    비밀번호 확인
                  </label>
                  <input
                    type="password"
                    className="form-control"
                    id="password2"
                    name="password2"
                    value={password2}
                    onChange={(e) => setPassword2(e.target.value)}
                  />
                  {error && <p className="fail-vali text-start">{error}</p>}
                </div>
                <div className="btn-area">
                  <button className="btn btn-gold" type="submit">
                    비밀번호 변경
                  </button>
                </div>
              </form>
            )}
          </div>
        </div>
      </section>
    </main>
  )
}

export default Security