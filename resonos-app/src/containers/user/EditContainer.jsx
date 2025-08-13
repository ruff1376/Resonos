import React, { useEffect, useState } from 'react'
import * as ur from '../../apis/user'
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
      console.log(response)
      setSuccess(true)
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
    <div className="container">
      <Header />
      <UserEditForm
        badgeList={badgeList}
        badgeName={badgeName}
        user={user}
        onSubmit={onSubmit}
        result={result}
        success={success}
      />
      <Footer />
    </div>
  )
}

export default EditContainer