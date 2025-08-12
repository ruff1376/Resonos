import React, { useEffect, useState } from 'react'
import Security from '../../components/user/Security'
import * as ur from '../../apis/user'
import {MySwal} from '../../apis/alert'
import { useNavigate } from 'react-router-dom'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'

const SecurityContainer = () => {

  const [lastPath, setLastPath] = useState()
  const [provider, setProvider] = useState()
  const [vali, setVali] = useState(false)
  const [error, setError] = useState()
  const [brError, setBrError] = useState()

  const navigate = useNavigate()

  // 비밀번호 확인 요청
  const onCheckPassword = async (e, password) => {
    e.preventDefault();
    let response
    try {
      response = await ur.checkPassword(password)
      if(response.status === 200) {
        setVali(true)
      }
    } catch (e) {
      if(e.response.status === 401) {
        MySwal.fire({
          position: "center",
          icon: "warning",
          title: "권한이 없습니다.",
          showConfirmButton: false,
          timer: 800,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        })
      }
      console.error('error :', e)
      setError(e.response.data);
    }
  };

  // 비밀번호 변경 요청
  const onChangePassword = async (e, password, password2) => {
    e.preventDefault();
    let response
    try {
      let formData = new FormData()
      formData.append('password', password)
      formData.append('password2', password2)
      response = await ur.changePassword(formData)

      if(response.status === 200) {
        MySwal.fire({
          position: "center",
          icon: "success",
          title: "비밀번호가 변경되었습니다, \n 로그인페이지로 이동합니다.",
          showConfirmButton: false,
          timer: 1000,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        })
        ur.logout()
        sessionStorage.removeItem('isLogin')
        sessionStorage.removeItem('roles')
        sessionStorage.removeItem('userInfo')
        setTimeout(() => {
          navigate('/login')
        }, 1100)
      }
    } catch (e) {
      if(e.response.data[0].defaultMessage)
        setBrError(e.response.data[0].defaultMessage)
      if(e.response.status === 401) {
        MySwal.fire({
          position: "center",
          icon: "warning",
          title: "권한이 없습니다.",
          showConfirmButton: false,
          timer: 800,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        })
      }
      console.error('error :', e.response)
    }
  };

  // 초기 데이터 요청
  const getUserInfo = async () => {
    let response

    try {
      response = await ur.getUserInfo()

      if(response.status === 200) {
        const data = response.data
        setLastPath(data.lastPath)
        setProvider(data.provider)
      }
    } catch(e) {
      console.error('error :', e)
    }
  }

  // 마운트 시 초기 데이터 요청
  useEffect(() => {
    getUserInfo()
  }, [])

  return (
    <div className="container">
      <Header />
      <Security
        lastPath={lastPath}
        provider={provider}
        vali={vali}
        error={error}
        onCheckPassword={onCheckPassword}
        onChangePassword={onChangePassword}
        setError={setError}
        brError={brError}
      />
      <Footer />
    </div>
  )
}

export default SecurityContainer