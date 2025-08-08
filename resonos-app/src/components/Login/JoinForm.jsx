import React, { useState } from 'react'
import * as ur from '../../apis/user'

function JoinForm() {

  const [formData, setFormData] = useState({
    username: '',
    nickname: '',
    email: '',
    password: '',
    password2: '',
  })

  const [errors, setErrors] = useState({
    username: '',
    nickname: '',
    email: '',
    password: '',
    password2: '',
  })

  const handleChange = (e) => {
    const { name, value } = e.target
    console.log(name)
    setFormData(prev => ({ ...prev, [name]: value }))
    // 유효성 검증
    checkField(name, value)
  }

  // 필드별 유효성 검증 함수
  const checkField = async (name, value) => {
    let errorMsg = ''
    let response

    try {
      switch (name) {
        case 'username':
          response = await ur.checkId(value)
          break
        case 'nickname':
          response = await ur.checkNickname(value)
          break
        case 'email':
          response = await ur.checkEmail(value)
          break
        case 'password':
          response = await ur.checkPw(value)
          break
        case 'password2':
          if (value !== formData.password) {
            errorMsg = '비밀번호가 일치하지 않습니다.'
          } else errorMsg = '비밀번호가 일치합니다.'
        default:
          break
      }
    } catch(e) {
      errorMsg = e.response.data[0].defaultMessage
    }
    if(response) {
      errorMsg = response.data
      console.log(response)
    }
    setErrors(prev => ({ ...prev, [name]: errorMsg }))
  }

  const formCheck = async (e) => {
    e.preventDefault();

    const tempErrors = {};

    // 모든 필드를 await checkField로 검사하고 임시 에러 객체 수집
    for (const [key, value] of Object.entries(formData)) {
      let errorMsg = '';
      try {
        switch (key) {
          case 'username':
            await ur.checkId(value);
            break;
          case 'nickname':
            await ur.checkNickname(value);
            break;
          case 'email':
            await ur.checkEmail(value);
            break;
          case 'password':
            await ur.checkPw(value);
            break;
          case 'password2':
            if (value !== formData.password) {
              errorMsg = '비밀번호가 일치하지 않습니다.';
            }
            break;
          default:
            break;
        }
      } catch (e) {
        errorMsg = e?.response?.data?.[0]?.defaultMessage || '에러 발생';
      }

      tempErrors[key] = errorMsg;
      setErrors(prev => ({ ...prev, [key]: errorMsg }))
    }

    // 에러 있는지 판단
    const hasError = Object.values(tempErrors).some(msg => msg !== '')
    if (!hasError) {
      console.log('폼 데이터 제출', formData)
      onSubmit(formData)
    } else {
      console.log('에러 있음', tempErrors)
    }
  }

  const onSubmit = async (formData) => {
    try {
      const response = await ur.join(formData)
      if(response.status === 200)
        alert('환영')
    } catch(e) {
      console.error(e)
    }
  }

  return (
    <div className="con con-join d-flex justify-content-center">
      <form id="form" onSubmit={formCheck} className="user-form">
        <div
          className="g-recaptcha"
          data-sitekey="6LcttYErAAAAANkBhJQLsApQK7PxZmNsgW2PsaWp"
        ></div>
        <h2 className="text-light mb-4">회원가입</h2>
        <div className="input-area">
          {/* 아이디 */}
          <label htmlFor="username" className="profile-edit-label">
            아이디
          </label>
          <input
            name="username"
            value={formData.username}
            onChange={handleChange}
            type="text"
            className="form-control mb-3"
            placeholder="영문, 숫자 포함 6글자 이상"
          />
          <p className={errors.username === '사용가능한 아이디입니다.' ? 'fail-vali success' : 'fail-vali'}>{errors.username}</p>

          {/* 닉네임 */}
          <label htmlFor="nickname" className="profile-edit-label">
            닉네임
          </label>
          <input
            name="nickname"
            value={formData.nickname}
            onChange={handleChange}
            type="text"
            className="form-control mb-3"
            placeholder="영문 + 숫자, 한글 + 숫자, 영문, 숫자 조합 2글자 이상 10글자 이하"
          />
          <p className={errors.nickname === '사용가능한 닉네임입니다.' ? 'fail-vali success' : 'fail-vali'}>{errors.nickname}</p>

          {/* 이메일 */}
          <label htmlFor="email" className="profile-edit-label">
            이메일
          </label>
          <input
            name="email"
            value={formData.email}
            onChange={handleChange}
            type="email"
            className="form-control mb-3"
            placeholder="이메일을 입력해주세요."
          />
          <p className={errors.email === '유효한 이메일입니다.' ? 'fail-vali success' : 'fail-vali'}>{errors.email}</p>

          {/* 비밀번호 */}
          <label htmlFor="password" className="profile-edit-label">
            비밀번호
          </label>
          <input
            name="password"
            value={formData.password}
            onChange={handleChange}
            type="password"
            className="form-control mb-3"
            placeholder="영문자, 숫자, 특수문자 조합으로 8 ~ 20 글자 입력해주세요."
          />
          <p className={errors.password === '유효한 비밀번호입니다.' ? 'fail-vali success' : 'fail-vali'}>{errors.password}</p>

          {/* 비밀번호 확인 */}
          <label htmlFor="password2" className="profile-edit-label">
            비밀번호 확인
          </label>
          <input
            name="password2"
            value={formData.password2}
            onChange={handleChange}
            type="password"
            className="form-control mb-3"
            placeholder="비밀번호와 같게 입력해주세요."
          />
          <p className={errors.password2 === '비밀번호가 일치합니다.' ? 'fail-vali success' : 'fail-vali'}>{errors.password2}</p>
        </div>
        <button id="join-button" className="btn btn-gold w-100 mb-2" type="submit">
          회원가입
        </button>
      </form>
    </div>
  )
}

export default JoinForm
