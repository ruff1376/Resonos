import React, { useEffect, useState } from 'react'
import * as ur from '../../apis/user'
import {MySwal} from '../../apis/alert'
import UserEditForm from '../../components/user/UserEditForm'
import Header from '../../components/Header/Header'
import Footer from '../../components/Footer/Footer'

const EditContainer = () => {

  const [badgeList, setBadgeList] = useState([])
  const [badgeName, setBadgeName] = useState('')
  const [user, setUser] = useState({})
  const [result, setResult] = useState({})
  const [success, setSuccess] = useState()

  // 회원정보 수정 요청
  const onSubmit = async (data) => {
    try {
      const response = await ur.updateUserInfo(data)
      if(response.status === 200) {
        MySwal.fire({
          position: "center",
          icon: "success",
          title: "프로필이 변경되었습니다.",
          showConfirmButton: false,
          timer: 800,
          customClass: {
            popup: 'follow-popup',
            icon: 'success-icon',
            title: 'alert-title'
          }
        })
      }
    } catch(e) {
      console.error(e)
      setResult(e.response.data)
      setSuccess(false)
    }
  }

  // 유저 정보 요청
  const getUserInfo = async () => {
    try {
      const response = await ur.getUserEditInfo()
      const data = response.data

      setBadgeList(data.badgeList)
      setBadgeName(data.badgeName)
      setUser(data.user)
    } catch(e) {
      console.error(e)
    }
  }

  // 마운트 시 데이터 요청
  useEffect(() => {
    getUserInfo()
  }, [])

  return (
    <>
      <Header />
      <div className="container">
        <UserEditForm
          badgeList={badgeList}
          badgeName={badgeName}
          user={user}
          onSubmit={onSubmit}
          result={result}
          success={success}
        />
      </div>
      <Footer />
    </>
  )
}

export default EditContainer