import React, { useEffect, useRef, useState } from 'react'
import { Link } from 'react-router-dom';

// onChange 이벤트 디바운스
function useDebounce(value, delay) {
  console.log('useDebounce 호출')
  const [debouncedValue, setDebouncedValue] = useState(value)
  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value)
    }, delay)
    return () => {
      clearTimeout(handler)
    }
  }, [value, delay])
  return debouncedValue
}

const FindIdForm = ({emailError, onCheckEmail}) => {

  const [email, setEmail] = useState("");
  const debounceKeyword = useDebounce(email, 300)

  const [certiVisible, setCertiVisible] = useState(false);
  const [certiInput, setCertiInput] = useState("");
  const [certiError, setCertiError] = useState("");
  const [idVisible, setIdVisible] = useState(false);
  const [username, setUsername] = useState("");

  const isFirstRender = useRef(true)

  const handleSendCerti = () => {
  }

  // 이메일 입력시 이메일 체크 요청
  useEffect(() => {
    if(isFirstRender.current) {
      isFirstRender.current = false
      return
    }

    onCheckEmail(email)
  }, [debounceKeyword])

  return (
    <main className="con con-find-id d-flex justify-content-center">
      <div className="user-form">
        <h2 className="text-light mb-4">아이디 찾기</h2>
        <div className="input-area">
          {/* 이메일 */}
          <div className="email-area position-relative">
            <label htmlFor="email" className="profile-edit-label">
              이메일
            </label>
            <input
              id="email"
              type="email"
              className="form-control mb-3"
              placeholder="이메일을 입력해주세요."
              value={email}
              onChange={(e) => setEmail(e.target.value)}
            />
            <button
              id="certi-button"
              className="btn btn-gold"
              type="button"
              onClick={handleSendCerti}
            >
              인증번호 전송
            </button>
            <p className="fail-vali">{emailError != '' && emailError}</p>
          </div>

          {/* 인증번호 입력 */}
          {certiVisible && (
            <div className="certi">
              <label htmlFor="certi-input" className="profile-edit-label">
                인증번호
              </label>
              <input
                id="certi-input"
                type="text"
                className="form-control mb-3"
                value={certiInput}
                onChange={(e) => setCertiInput(e.target.value)}
              />
              <p className="fail-vali">{certiError}</p>
            </div>
          )}

          {/* 아이디 */}
          {idVisible && (
            <div className="id">
              <label htmlFor="username" className="profile-edit-label">
                회원님의 아이디
              </label>
              <input
                id="username"
                type="text"
                className="form-control mb-3"
                value={username}
                readOnly
              />
            </div>
          )}
        </div>

        <div className="mt-10">
          <Link to="/find-pw" className="btn btn-outline-gold w-100 mb-2">
            비밀번호 찾기
          </Link>
          <Link to="/login" className="btn btn-gold w-100 mb-2">
            로그인 화면
          </Link>
        </div>
      </div>
    </main>
  )
}

export default FindIdForm