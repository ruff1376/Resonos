import React, { useEffect, useRef, useState } from 'react'
import { Link } from 'react-router-dom';

// onChange 이벤트 디바운스
function useDebounce(value, delay) {
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

const FindPwForm = ({usernameError, onCheckUsername, checkUsername, onChangePwSendMail}) => {

  const [username, setUsername] = useState("");
  const debounceKeyword = useDebounce(username, 300)

  const isFirstRender = useRef(true)

  const handleSendEmail = () => {
    if (!checkUsername) return;
    onChangePwSendMail(username);
  };

  useEffect(() => {
    if(isFirstRender.current) {
      isFirstRender.current = false
      return
    }

    onCheckUsername(username)
  }, [debounceKeyword])

  return (
    <main className="con con-find-id d-flex justify-content-center">
      <div className="user-form">
        <h2 className="text-light mb-4">비밀번호 찾기</h2>

        <div className="input-area">
          {/* 아이디 */}
          <div className="id position-relative">
            <label htmlFor="username" className="profile-edit-label">
              아이디
            </label>
            <input
              id="username"
              type="text"
              className="form-control mb-3"
              placeholder="회원님의 이메일로 임시 비밀번호가 발송됩니다."
              value={username}
              onChange={(e) => setUsername(e.target.value)}
            />
            <p className={`fail-vali ${checkUsername.current ? 'success' : ''}`} id="usernameError">
              {usernameError}
            </p>
            <button
              onClick={handleSendEmail}
              id="certi-button"
              className={`btn btn-gold ${checkUsername.current ? '' : 'non-event'}`}
              type="button"
            >
              메일 전송
            </button>
          </div>
        </div>

        <div className="mt-10">
          <Link to="/find-id" className="btn btn-outline-gold w-100 mb-2">
            아이디 찾기
          </Link>
          <Link to="/login" className="btn btn-gold w-100 mb-2">
            로그인 화면
          </Link>
        </div>
      </div>
    </main>
  )
}

export default FindPwForm