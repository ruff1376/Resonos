import React, { useEffect, useState } from 'react'
import * as ur from '../../apis/user'
import UserEditForm from '../../components/user/UserEditForm'

const EditContainer = () => {

  const [badgeList, setBadgeList] = useState([])
  const [badgeName, setBadgeName] = useState('')
  const [user, setUser] = useState({})
  const [result, setResult] = useState({})
  const [success, setSuccess] = useState()

  const getUserInfo = async () => {
    try {
      const response = await ur.getUserEditInfo()
      const data = response.data
      console.log(data)

      setBadgeList(data.badgeList)
      setBadgeName(data.badgeName)
      setUser(data.user)
    } catch(e) {
      console.error(e)
    }
  }

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

  useEffect(() => {
    getUserInfo()
  }, [])

  return (
    <UserEditForm
      badgeList={badgeList}
      badgeName={badgeName}
      user={user}
      onSubmit={onSubmit}
      result={result}
      success={success}
    />
  )
}

export default EditContainer