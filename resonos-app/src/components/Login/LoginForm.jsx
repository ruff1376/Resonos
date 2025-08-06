import { useContext } from 'react'
import { LoginContext } from '../../contexts/LoginContextProvider'
import { useLocation, useParams } from 'react-router-dom'
import './LoginForm.css'

const LoginForm = () => {

  // 🚚 LoginContext - 로그인 함수
  const {login} = useContext(LoginContext)

  const location = useLocation()
  const query = new URLSearchParams(location.search)
  const error = query.get("error")

  const onLogin = e => {
    e.preventDefault()
    const form = e.target
    const username = form.username.value
    const password = form.password.value

    login(username, password)
  }

  return (
    <div className="con d-flex justify-content-center">
      <form onSubmit={(e) => onLogin(e)} className="user-form">
        <img
          src="/img/resonosLogo.png"
          width="250"
          height="167"
          alt="RESONOS Logo"
          className="img-fluid rounded mb-3"
        />

        <input
          type="text"
          name="username"
          className="form-control mb-3 w-80"
          placeholder="아이디"
          required
        />

        <input
          type="password"
          name="password"
          className="form-control mb-3 w-80"
          placeholder="비밀번호"
          required
        />

        {error && (
          <p className="fail-vali">
            {error === 'duplicate_email'
              ? '이미 가입된 이메일입니다.'
              : error === 'true'
              ? '아이디 또는 비밀번호가 잘못되었습니다.'
              : ''}
          </p>
        )}

        <div className="checkbox-area">
          <div className="item">
            <input
              className="form-check-input"
              type="checkbox"
              id="remember-id-check"
              // checked={rememberId}
              // onChange={() => setRememberId(!rememberId)}
            />
            <label className="form-check-label" htmlFor="remember-id-check">
              아이디 저장
            </label>
          </div>
          <div className="item">
            <input
              className="form-check-input"
              type="checkbox"
              id="remember-me-check"
              // onChange={} // 자동 로그인 기능 처리 필요 시 구현
            />
            <label className="form-check-label" htmlFor="remember-me-check">
              자동 로그인
            </label>
          </div>
        </div>

        <button className="btn btn-gold w-100 mb-2" type="submit">
          로그인
        </button>

        <div className="find-area">
          <a href="/find-id" className="login-link d-block mt-2">
            아이디 찾기
          </a>
          <a href="/find-pw" className="login-link d-block mt-2">
            비밀번호 찾기
          </a>
        </div>

        <div className="text-secondary my-3">또는</div>

        <button
          type="button"
          className="btn social-btn"
          onClick={() => (window.location.href = '/oauth2/authorization/google')}
        >
          Google로 로그인
        </button>
        <button
          type="button"
          className="btn social-btn"
          onClick={() => (window.location.href = '/oauth2/authorization/kakao')}
        >
          Kakao로 로그인
        </button>
        <button
          type="button"
          className="btn social-btn"
          onClick={() => (window.location.href = '/oauth2/authorization/naver')}
        >
          Naver로 로그인
        </button>

        <div>
          <span className="text-secondary">아직 회원이 아니신가요?</span>
          <a href="/join" className="login-link">
            회원가입
          </a>
        </div>
      </form>
    </div>
  )
}

export default LoginForm