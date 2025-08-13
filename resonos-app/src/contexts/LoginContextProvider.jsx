import React, { createContext, useEffect, useState } from 'react'
import api from '../apis/api'
import * as auth from '../apis/auth'
import * as Swal from '../apis/alert'
import Cookies from 'js-cookie'
import { useNavigate } from 'react-router-dom'

// 🚚 컨텍스트 생성
export const LoginContext = createContext()

const LoginContextProvider = ({children}) => {

  // state
  // 로그인 여부
  const [isLogin, setIsLogin] = useState(() => {
    const savedIsLogin = sessionStorage.getItem('isLogin')
    return savedIsLogin ?? false
  })
  // 사용자 정보
  const [userInfo, setUserInfo] = useState(() => {
    const savedUserInfo = sessionStorage.getItem('userInfo')
    return savedUserInfo ? JSON.parse(savedUserInfo) : null
  })
  // 권한 정보
  const [roles, setRoles] = useState(() => {
    const savedRoles = sessionStorage.getItem('userInfo')
    return savedRoles ? JSON.parse(savedRoles) : {isUser : false, isAdmin : false}
  })
  // 로딩 중
  const [isLoading, setIsLoading] = useState(true)


  // 페이지 이동
  const navigate = useNavigate()

  // 🔐 로그인 함수
  const login = async (username, password, rememberId, rememberMe) => {
    console.log(`username : ${username}`)
    console.log(`password : ${password}`)

    try {
      const response = await auth.login(username, password)
      const data = response.data
      const status = response.status
      console.dir(`data : ${data}`)
      console.log(`status : ${status}`)

      // 로그인 성공 ✅
      if(status == 200) {

        if(rememberId) {
          localStorage.setItem('username', username)
          localStorage.setItem('rememberId', true)
        } else {
          localStorage.removeItem('username')
          localStorage.removeItem('rememberId')
        }

        if(rememberMe) localStorage.setItem('rememberMe', true)
        else localStorage.removeItem('rememberMe')

        // 로그인 세팅 - loginSetting()
        loginSetting(data)

        // 로그인 성공 alert
        Swal.alert(`로그인 성공`, `메인 화면으로 이동합니다.`, `success`, () => {navigate('/')})
      }
    } catch (e) {
      console.error(e.response)
      navigate('/login?error=true')
    }
  }

  // 로그인 세팅
  /**
   *
   * @param {*} authorization : Bearer {jwt}
   * @param {*} data          : {user}
   */
  const loginSetting = (data) => {
    // 로그인 여부
    setIsLogin(true)
    sessionStorage.setItem("isLogin", "true")
    // 사용자 정보
    sessionStorage.setItem("userInfo", JSON.stringify(data))
    // 권한 정보
    const updateRoles = {isUser: false, isAdmin: false}
    data.authList.forEach(obj => {
      if(obj.auth == "ROLE_USER") updateRoles.isUser = true
      if(obj.auth == "ROLE_ADMIN") updateRoles.isAdmin = true
    })
    setRoles(updateRoles)
    sessionStorage.setItem("roles", JSON.stringify(updateRoles))
  }

  // 자동 로그인
  // 1️⃣ 쿠키에서 JWT 가져오기
  // 2️⃣ JWT 있으면, 사용자 정보 요청
  // 3️⃣ 로그인 세팅 (로그인 여부, 사용자 정보, 권한)
  // 🍪 쿠키에 저장된 JWT 를 읽어와서 로그인 처리
  const autoLogin = async () => {
    let response
    let data

    try {
      response = await auth.info()
      console.log('response :', response)

    } catch(e) {
      console.error(`error : ${e}`)
      return
    }

    if(response.data == 'UNAUTHORIZED' || response.status == 401) {
      console.error('JWT 가 만료되었거나 인증에 실패하였습니다.')
      return
    }

    // 인증 성공
    console.log('jwt 로 자동 로그인 성공')
    data = response.data

    // 로그인 세팅 - loginSetting()
    loginSetting(data)
  }

  // 🍃 로그아웃 함수
  const logout = (force=false) => {
    // 강제 로그아웃
    if(force) {
      // 로딩 중
      setIsLoading(true)

      // 로그아웃 세팅
      logoutSetting()
      // 페이지 이동 -> "/" (메인)
      navigate("/")
      // 로딩 끝
      setIsLoading(false)
      return
    }

    // 로그아웃 확인
    Swal.confirm('로그아웃 하시겠습니까?', '로그아웃을 진행합니다.', 'warning', result => {
      if(result.isConfirmed) {
        Swal.alert("로그아웃 성공", "로그아웃 되었습니다.", "success")
        // 로그아웃 세팅
        logoutSetting()
        // 페이지 이동 -> "/" (메인)
        navigate("/")
        return
      }
    })
  }

  // 로그아웃 세팅
  const logoutSetting = () => {
    // Headers 삭제
    api.defaults.headers.common.Authorization = undefined
    // isLogin false
    setIsLogin(false)
    sessionStorage.removeItem("isLogin")
    // UserData 삭제
    setUserInfo(null)
    sessionStorage.removeItem("userInfo")
    // 권한 삭제
    setRoles({isUser: false, isAdmin: false})
    sessionStorage.removeItem("roles")
    // 쿠키 삭제
    Cookies.remove("jwt")
  }

  useEffect(() => {
    const savedIsLogin = sessionStorage.getItem('isLogin')
    const rememberMe = localStorage.getItem('rememberMe')
    console.log("자동 로그인 :", rememberMe)
    if(!rememberMe) return
    if(!savedIsLogin || savedIsLogin == false) {
      autoLogin()
    }
  }, [])

  return (
    // 컨텍스 값 지정 -> value{?, ?}
    <LoginContext.Provider value={{isLogin, login, userInfo, roles, isLoading, logout, api}}>
      {children}
    </LoginContext.Provider>
  )
}

export default LoginContextProvider