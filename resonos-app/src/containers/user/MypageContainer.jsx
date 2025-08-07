import React, { useEffect } from 'react'
import UserInfo from '../../components/user/UserInfo'
import UserResource from '../../components/user/UserResource'

const MypageContainer = () => {

  const getUserInfo = () => {
    try {

    } catch(e) {
      console.error('error : ', e)
    }
  }

  useEffect(() => {

  }, [])

  return (
    <div className="container">
      <UserInfo />
      <UserResource />
    </div>
  )
}

export default MypageContainer